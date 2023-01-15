#include <conio.h>
#include <stdio.h>
#include <tchar.h>
#include <windows.h>

#include <chrono>
#include <iostream>
#include <mutex>
#include <thread>
#include <vector>

#include "camera_send.h"
#include "virtual_output.h"


// Camera
VirtualOutput* camera;
double _width = 0;
double _height = 0;
double _fps = 0;

// Buffer data from GMS
unsigned char* data_buff;
unsigned char* data_ready;
int data_buffs;

// Threads
std::thread thread_thing;
std::atomic<bool> shouldQuit;
std::mutex mut;

extern "C" __declspec(dllexport) double camera_is_installed()
{
    LPCWSTR guid = L"CLSID\\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}";
    HKEY key = nullptr;

    if (RegOpenKeyExW(HKEY_CLASSES_ROOT, guid, 0, KEY_READ, &key) != ERROR_SUCCESS) {
        return 0;
    }
    else
    {
        RegCloseKey(key);
        return 1;
    }
}

extern "C" __declspec(dllexport) double set_output(double width, double height, double fps)
{
    if (camera != NULL)
    {
        return 0;
    }

    _width = width;
    _height = height;
    _fps = fps;
}

extern "C" __declspec(dllexport) double start_camera(unsigned char* buff, unsigned char* ready, double buff_nums)
{
    std::lock_guard<std::mutex> lock(mut);

    if (camera != NULL)
    {
        return 0;
    }

    if (!(_width > 0 && _height > 0 && _fps > 0))
    {
        return 0;
    }

    data_buff = buff;
    data_ready = ready;
    data_buffs = (int) buff_nums;

    camera = new VirtualOutput(_width, _height, _fps, libyuv::FOURCC_ABGR);
    thread_thing = std::thread(camera_impl);

    shouldQuit = false;

    return 0;
}

extern "C" __declspec(dllexport) double stop_camera()
{
    std::lock_guard<std::mutex> lock(mut);

    if (camera != NULL)
    {
        shouldQuit = true;
        thread_thing.join();
        camera->stop();
        delete camera;
        camera = NULL;
    }

    return 0;
}

void camera_impl()
{
    int curr_buff = 0;
    while (TRUE)
    {
        std::this_thread::sleep_for(std::chrono::microseconds(50));

        if (!shouldQuit)
        {
            // Send frame
            unsigned char* buff = &data_buff[curr_buff * (int)_width * (int)_height * 4];
            unsigned char* ready = &data_ready[curr_buff];

            if (*ready == 2)
            {
                camera->send(buff);
                *ready = 0;
                curr_buff = (curr_buff + 1) % data_buffs;
            }
        }
        else
        {
            return;
        }
    }
}

#pragma once
void camera_impl();
extern "C" __declspec(dllexport) double set_output(double width, double height, double fps);
extern "C" __declspec(dllexport) double start_camera(unsigned char* buff, unsigned char* ready, double buff_nums);
extern "C" __declspec(dllexport) double stop_camera();
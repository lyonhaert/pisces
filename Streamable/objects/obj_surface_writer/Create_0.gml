/// @description Create buffer
output_width=1920
output_height=1080
output_fps=60

var surface_width = room_width;
var surface_height = room_height;
display_surface = surface_create(surface_width, surface_height);
final_surface = surface_create(output_width, output_height);

curr_buff = 0;
num_buffers = 3;
indv_size = output_width * output_height * 4;
buffer_size = indv_size * num_buffers;

// Create shared memory:
buff_num = 0
buffer = buffer_create(buffer_size, buffer_fast, 1);
buffer_addr = buffer_get_address(buffer);
flag_buffer = buffer_create(8, buffer_fast, 1);
flag_buffer_addr = buffer_get_address(flag_buffer);
time_since_frame = 0;
depth = -6000;
set_output(output_width, output_height, output_fps);
start_camera(buffer_addr, flag_buffer_addr, num_buffers);

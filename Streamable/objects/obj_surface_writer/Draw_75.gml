// Copy all drawn things to the surface:
if !surface_exists(final_surface)
	final_surface = surface_create(output_width, output_height);

if !surface_exists(display_surface) return;

buffer_seek(flag_buffer, buffer_seek_start, curr_buff);
if buffer_read(flag_buffer, buffer_u8) != 0 return;

buffer_seek(flag_buffer, buffer_seek_start, curr_buff);
buffer_write(flag_buffer, buffer_u8, 1);

var surface_width = surface_get_width(display_surface);
var surface_height = surface_get_height(display_surface);
var room_aspect_ratio = surface_width / surface_height;

surface_set_target(final_surface)

if room_aspect_ratio == (16 / 9)
{
	draw_surface_stretched(display_surface, 0, 0, output_width, output_height);
}
else if room_aspect_ratio < (16 / 9) // Image is too narrow
{
	var height_ratio = output_height / surface_height;
	var actual_width = height_ratio * surface_width;
	var draw_x = (output_width - actual_width) / 2;
	draw_surface_stretched(display_surface, draw_x, 0, actual_width, output_height);
}
else // Image is too wide
{
	var width_ratio = output_width / surface_width;
	var actual_height = width_ratio * surface_height;
	var draw_y = (output_height - actual_height) / 2;
	draw_surface_stretched(display_surface, 0, draw_y, output_width, actual_height);
}


surface_reset_target();
	
buffer_get_surface(buffer, final_surface, indv_size * curr_buff);
	
buffer_seek(flag_buffer, buffer_seek_start, curr_buff);
buffer_write(flag_buffer, buffer_u8, 2);
	
curr_buff = (curr_buff + 1) % num_buffers;
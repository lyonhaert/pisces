draw_set_font(fnt_beleren_large)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)

var draw_x = x
var draw_y = y
var draw_string = action_msg

draw_set_alpha(image_alpha)
draw_set_color(c_black)
draw_text(draw_x + 5, draw_y + 5, draw_string)
draw_set_color(c_white)
draw_text(draw_x, draw_y, draw_string)

if camera_mirroring_enabled() {
	surface_set_target(obj_surface_writer.display_surface)

	draw_set_alpha(image_alpha)
	draw_set_color(c_black)
	draw_text(draw_x + 5, draw_y + 5, draw_string)
	draw_set_color(c_white)
	draw_text(draw_x, draw_y, draw_string)

	surface_reset_target()
}

draw_set_alpha(1)

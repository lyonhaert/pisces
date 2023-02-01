draw_set_font(fnt_beleren_large)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)

draw_shadowedText(action_msg, x, y, shadow_offset,
	image_alpha, is_error ? error_color : c_black,
	image_alpha, c_white)
	
if !is_error && camera_mirroring_enabled() {
	surface_set_target(obj_surface_writer.display_surface)

	draw_shadowedText(action_msg, x, y, shadow_offset,
		image_alpha, is_error ? error_color : c_black,
		image_alpha, c_white)

	surface_reset_target()
}

draw_set_alpha(1)

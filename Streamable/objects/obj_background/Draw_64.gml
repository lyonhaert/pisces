/// @description Draw the background
var txtX = 10;
var txtY = 10;

var numrepeats = obj_keyboard_dispatch.num_repeats
var txtKBDRepeats = numrepeats > 0 ? string(numrepeats) : ""

var txtHand = "Hand: " + string(array_length(obj_hand.stack_list));
var txtDeck = "Deck: " + string(array_length(obj_deck.stack_list));

var txtHand = txtDeck + "\n" + txtHand;

var topLeftHandY = room_height - ((1040 * obj_options.default_scaling) / 2) - 10;

var phases = camera_mirroring_enabled() ? 2 : 1
var mirror_phase = false

repeat(phases) {
	if mirror_phase surface_set_target(obj_surface_writer.display_surface)
	
	draw_set_alpha(1);
	draw_sprite_tiled(obj_options.background_sprite, image_index, offset_x, offset_y);

	if !mirror_phase && obj_options.draw_grid {
		draw_set_alpha(.1)
		draw_set_color(c_white)
		for (var ix = obj_options.grid_size; ix < room_width; ix += obj_options.grid_size) {
			draw_line(ix, 0, ix, room_height)
		}
		for (var iy = obj_options.grid_size; iy < room_height; iy += obj_options.grid_size) {
			draw_line(0, iy, room_width, iy)
		}
	}

	if !mirror_phase {
		draw_set_font(fnt_segoe);
		draw_set_halign(fa_left);
		
		draw_set_valign(fa_top);
		
		draw_shadowedText(txtKBDRepeats, txtX, txtY)
		draw_set_valign(fa_bottom);
				
		draw_shadowedText(txtHand, txtX, topLeftHandY)
	}
	
	if mirror_phase surface_reset_target()
	
	mirror_phase = true
}

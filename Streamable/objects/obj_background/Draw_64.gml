/// @description Draw the background
draw_set_alpha(1);
draw_sprite_tiled(obj_options.background_sprite, image_index, offset_x, offset_y);

var txtX = 10;
var txtY = 10;
var txtHand = "Hand: " + string(array_length(obj_hand.stack_list));
var txtDeck = "Deck: " + string(array_length(obj_deck.stack_list));

var txtHand = txtDeck + "\n" + txtHand;

var txtRes = string(room_width) + " x " + string(room_height);

var topLeftHandY = room_height - ((1040 * obj_options.default_scaling) / 2) - 10;

draw_set_font(fnt_segoe);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

draw_set_alpha(0.85);
draw_set_color(c_black);
draw_text(txtX + 2, topLeftHandY + 2, txtHand);
draw_text(txtX + 2, (txtY * 4) + 2, txtRes);

draw_set_alpha(1);
draw_set_color(c_white);
draw_text(txtX, topLeftHandY, txtHand);
draw_text(txtX, (txtY * 4), txtRes);

if camera_mirroring_enabled()
{
	surface_set_target(obj_surface_writer.display_surface);
	
	draw_set_alpha(1);
	draw_sprite_tiled(obj_options.background_sprite, image_index, offset_x, offset_y);

	/*
	draw_set_alpha(0.85);
	draw_set_color(c_black);
	draw_text(txtX + 2, topLeftHandY + 2, txtHand);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_text(txtX, topLeftHandY, txtHand);
	*/
	
	surface_reset_target();
}

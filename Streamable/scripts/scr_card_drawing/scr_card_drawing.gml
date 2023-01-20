function obj_card_drawing() {
	var x_offset = sprite_width / 2;
	var y_offset = sprite_height / 2;

	// The corners of the card:
	var draw_points = {
		x1 : x - x_offset,
		y1 : y - y_offset,
		x2 : x + x_offset,
		y2 : y - y_offset,
		x3 : x + x_offset,
		y3 : y + y_offset,
		x4 : x - x_offset,
		y4 : y + y_offset
	}

	//tapped/untapped lower-left corners for counters
	var untapx4 = draw_points.x4
	var untapy4 = draw_points.y4
	var tapx3 = x - y_offset
	var tapy3 = y + x_offset
	
	var rotated = image_angle != 0;
	var skewing = not rotated and is_dragged;

	// Rotation:
	if rotated
	{
		rotate_around_point(x, y, image_angle, draw_points);
	}

	// Skew effect:
	if skewing {
		skew_points_around_center(skew_x, skew_y, sprite_width, sprite_height, draw_points);
	}

	// Hovering animation:
	if time_hovering != 0 and not is_zoomed
	{
		var time_cycle = degtorad(time_hovering);
		var spent = sin(time_cycle) * sprite_height / 32;
		draw_points.y1 += spent
		draw_points.y2 += spent
		draw_points.y3 += spent
		draw_points.y4 += spent
		
		tapy3 += spent
		untapy4 += spent
	}

	var off = sprite_width * (image_xscale - obj_options.default_scaling) * !is_zoomed;

	var x1 = draw_points.x1;
	var y1 = draw_points.y1;
	var x2 = draw_points.x2;
	var y2 = draw_points.y2;
	var x3 = draw_points.x3;
	var y3 = draw_points.y3;
	var x4 = draw_points.x4;
	var y4 = draw_points.y4;

	var spr = get_card_sprite(self);

	var phases = camera_mirroring_enabled() ? 2 : 1
	var mirror_phase = false

	repeat(phases) {
		if mirror_phase {
			if !is_revealed {
				spr = obj_options.card_back_sprite
			}
		
			surface_set_target(obj_surface_writer.display_surface)
		}
	
		if (skewing)
		{
			draw_sprite_pos_fixed(spr_card_shadow, image_index, x1 + off, y1 + off, x2 + off, y2 + off, x3 + off, y3 + off, x4 + off, y4 + off, c_white, 0.25);
			if (is_upsidedown) {
				draw_sprite_pos_fixed(spr, image_index, x3, y3, x4, y4, x1, y1, x2, y2, c_white, 1);
			} else {
				draw_sprite_pos_fixed(spr, image_index, x1, y1, x2, y2, x3, y3, x4, y4, c_white, 1);
			}
		}
		else
		{
			// Fixed is slower and not needed if not skewed
			draw_sprite_pos(spr_card_shadow, image_index, x1 + off, y1 + off, x2 + off, y2 + off, x3 + off, y3 + off, x4 + off, y4 + off, 0.25);
			if (is_upsidedown) {
				draw_sprite_pos(spr, image_index, x3, y3, x4, y4, x1, y1, x2, y2, 1);
			} else {		
				draw_sprite_pos(spr, image_index, x1, y1, x2, y2, x3, y3, x4, y4, 1);
			}
		}

		if is_zoomed and not is_dragged and note_content != ""
		{
			// The side of the screen:
			var side_screen = 1 - 2 * (x > room_width / 2);

			var box_x1 = x + side_screen * .52 * sprite_width
			var box_x2 = x + side_screen * .77 * sprite_width + side_screen * string_width(note_content);
			var box_y1 = y - 0.05 * sprite_height;
			var box_y2 = y + 0.05 * sprite_height;

			draw_set_valign(fa_center);
			draw_set_halign(fa_center);

			draw_set_alpha(0.4);
			draw_roundrect_color_ext(box_x1, box_y1, box_x2, box_y2, 10, 10, c_black, c_black, false);
	
			///text
			draw_set_color(c_white);
			draw_set_alpha(0.90);
			draw_text(
				mean(box_x1, box_x2), 
				mean(box_y1, box_y2), 
			note_content);
		
			///reset for the other menus
			draw_set_alpha(1.0);
		}

		if !mirror_phase && (is_hovering || is_dragged || is_selected) && !is_zoomed
		{
			draw_sprite_pos_fixed(spr_border, image_index, x1, y1, x2, y2, x3, y3, x4, y4, c_white, 1);
		}

		if note_content != "" and not is_zoomed and not is_tapping
		{
			var lx4 = x4 + 0.05 * sprite_width;
			var ly4 = y4 - 0.05 * sprite_height;
			var lx3 = x3 - 0.05 * sprite_width;
			var ly3 = y3 - 0.20 * sprite_height;
			var x_note_center = x4 + (lx3 - lx4) * 0.5;
			var y_note_center = y4 + (ly3 - ly4) * 0.75;
		
			if tapped {
				/// if this is tapped update the above values to move the note appropriately
				lx4 = x3 + 0.05 * sprite_height;
				ly4 = y3 - 0.05 * sprite_width;
				lx3 = x2 - 0.05 * sprite_height;
				ly3 = y2 - 0.30 * sprite_width;
				x_note_center = x3 + (lx3 - lx4) * 0.5;
				y_note_center = y3 + (ly3 - ly4) * 0.75;
			}
		
			///this version is for notes just on board
			draw_set_valign(fa_center);
			draw_set_halign(fa_center);
		
			///box
			draw_set_alpha(is_hovering ? 0.4 : 0.15)
			draw_roundrect_color_ext(lx4, ly4, lx3, ly3, 10, 10, c_black, c_black, false);
	
			///text
			draw_set_color(c_white);
			draw_set_alpha(is_hovering ? 0.9 : 0.5)
		
			var text_scale_factor = 1 / (0.5 - 0.15);
			var text_scale = 0.25 + 0.5 * (obj_options.default_scaling - 0.15) * text_scale_factor;
			draw_text_transformed(x_note_center, y_note_center, note_content, text_scale, text_scale, 0);
		
			///reset for the other menus
			draw_set_alpha(1.0);
		}


		draw_set_font(fnt_segoe)
		var cX = tapped ? tapx3 : untapx4
		var cY = tapped ? tapy3 : untapy4
		
		if is_tapping {
			var f = tapped ? 1 - tap_angle_percentage : tap_angle_percentage
			cX = untapx4 + ((tapx3 - untapx4) * f)
			cY = untapy4 + ((tapy3 - untapy4) * f)
		}

		if counters[$ "default"] != 0 {
			draw_counter(cX, cY, countersDefaultName, counters[$ "default"])
		}
		
		var cIdx = 0
		repeat(array_length(countersOtherNames)) {
			cY -= (counterSize * 2) + 5
			draw_counter(cX, cY, countersOtherNames[cIdx], counters[$ countersOtherNames[cIdx]])
			cIdx++
		}
		
		if mirror_phase surface_reset_target()
		
		mirror_phase = true
	}
	
	delete draw_points
}

function draw_counter(cX, cY, name, num) {
	var snum = string(num)
	var swidth = string_width(snum) + 10
	
	var w = max(counterSize, swidth - counterSize)
	
	var ctrx1 = cX - w;
	var ctry1 = cY - counterSize;
	var ctrx2 = cX + counterSize;
	var ctry2 = cY + counterSize;
	
	draw_set_valign(fa_center);
	draw_set_halign(fa_center);
	
	draw_set_alpha(0.85);
	draw_roundrect_color_ext(ctrx1, ctry1, ctrx2, ctry2, 8, 8, c_black, c_black, false);
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_text(mean(ctrx2, ctrx1) + 1, cY + 1, string(num));
	
	if string_length(name) && (is_hovering || is_zoomed || is_dragged) {
		var ctrlblx1 = ctrx1 - 5;
		draw_set_halign(fa_right);
		draw_set_alpha(.9);
		draw_set_color(c_black);
		var scale = is_zoomed ? 1 : .8
		draw_text_transformed(ctrlblx1 - 1, cY - 1, name, scale, scale, 0);
		draw_text_transformed(ctrlblx1 - 1, cY + 1, name, scale, scale, 0);
		draw_text_transformed(ctrlblx1 + 1, cY - 1, name, scale, scale, 0);
		draw_text_transformed(ctrlblx1 + 2, cY + 2, name, scale, scale, 0);
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_text_transformed(ctrx1 - 5, cY, name, scale, scale, 0);
	}
}
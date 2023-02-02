/// @description Hovered
ticker = max(ticker - obj_options.since_last, -1);

if ticker <= 0 and clearing {
	instance_destroy(); 
	return;
}

if clearing return;

var prev_hovered = hovered;
bounding_x_start = x;
bounding_x_end = x + width + padding + padding;
bounding_y_start = y + padding - offset;
bounding_y_end = y + padding + height - offset;

is_in = point_in_rectangle(
	mouse_x, 
	mouse_y, 
	bbox_left, 
	bbox_top, 
	bbox_right, 
	bbox_bottom) and id == obj_selector.lowest_object;

var next_hovered = -1

for (var i = 0; i < array_length(options); i++)
{
	if array_containsEx(dividers, i)
	{
		bounding_y_start += divider_height;
		bounding_y_end += divider_height;
	}
	
	var in_rect = point_in_rectangle(
		mouse_x, 
		mouse_y, 
		bounding_x_start, 
		bounding_y_start, 
		bounding_x_end, 
		bounding_y_end) and is_in;
		
	if (in_rect) {
		next_hovered = i;
		
		break;
	}
		
	bounding_y_start += height;
	bounding_y_end += height;
}

hovered = next_hovered
if prev_hovered != hovered {
	if prev_hovered != -1 {
		options[prev_hovered].onunhover()
	}
	
	if hovered != -1 {
		options[hovered].onhover(owner, self)
	}
}

if is_in
{
	next_offset = next_offset - mouse_wheel_up() * height + mouse_wheel_down() * height;
	next_offset = clamp(next_offset, 0, surf_height - image_yscale);
}

offset = floor(mean(offset, offset, offset, offset, next_offset));

scroll_alpha = mean(scroll_alpha, scroll_alpha, is_in);

if mouse_check_button_released(mb_left) {
	var lo = obj_selector.lowest_object
	if lo == noone || lo.object_index != obj_menu {
		ticker = 30;
		clearing = true;
	} else if hovered != -1 && is_in {
		options[hovered].Perform(owner, self);
		click_option = hovered;
		click_point_x = mouse_x - bounding_x_start;
		click_point_y = mouse_y - bounding_y_start;
	}
}

/// @description Arrows
if !obj_options.debug_specials return;
if id != obj_selector.lowest_object return;

switch (keyboard_lastkey) {
	case vk_left: x -= 1; break;
	case vk_right: x += 1; break;
	case vk_up: y -= 1; break;
	case vk_down: y += 1; break;
}

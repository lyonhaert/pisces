/// @description Find the lowest object.
lowest_object = lowest_at_point(mouse_x, mouse_y);

if !f6pressed && keyboard_check(vk_f6)
{
	f6pressed = true;
	
	if lowest_object == noone {
		show_debug_message("lowest_object: noone")
		return
	}
	
	var objname = object_get_name(lowest_object.object_index)
	show_debug_message("lowest_object: " + objname + " " + string(lowest_object))
	if (lowest_object.object_index == obj_card) {
		with (lowest_object) {
			show_debug_message(" is_selected:" + string(is_selected) +
				" is_hovering:" + string(is_hovering) +
				" is_dragged:" + string(is_dragged) +
				" has current_menu:" + string(current_menu != noone))
		}
	}

	/*
	var _list2 = ds_list_create();
	var _num = collision_point_list(mouse_x, mouse_y, all, true, false, _list2, false);
	for (var i = 0; i < _num; i++) {
		var elem = _list2[| i];
		show_debug_message("cpl[" + string(i) + "]: " + object_get_name(elem.object_index) + " " + string(elem))
	}
	ds_list_destroy(_list2);
	*/
} else if f6pressed && !keyboard_check(vk_f6) {
	f6pressed = false;
}

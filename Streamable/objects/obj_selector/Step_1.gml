/// @description Find the lowest object.
lowest_object = lowest_at_point(mouse_x, mouse_y);

if !f6pressed && keyboard_check(vk_f6)
{
	f6pressed = true;
	//var lo = lowest_at_point(mouse_x, mouse_y);
	
	var _list2 = ds_list_create();
	var _num = collision_point_list(mouse_x, mouse_y, all, true, false, _list2, false);
	//_num += instance_position_list(mouse_x, mouse_y, all, _list2, false);
	for (var i = 0; i < _num; i++) {
		var elem = _list2[| i];
	}
	ds_list_destroy(_list2);
	
	show_debug_message(lowest_object);	
} else if f6pressed && !keyboard_check(vk_f6) {
	f6pressed = false;
}

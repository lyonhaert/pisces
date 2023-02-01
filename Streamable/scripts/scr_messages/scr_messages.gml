// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function find_message_subscribers(message_name) {
	var subscribers = [];

	with (all)
	{
		if !variable_instance_exists(id, "subscribed_events") continue;
		if subscribed_events[$ message_name] == undefined continue;
		
		array_push(subscribers, {
			"obj": id,
			"ev": subscribed_events[$ message_name]
		});
	}
	
	return subscribers;
}

function announce_action(msg, is_error = false) {
	with (obj_action_announcement) {
		//janky solution to prevent multiple duplicates from the same keypress
		// because of how obj_keyboard_dispatch's num_repeats works currently
		if action_msg == msg && age_ms < 500 return
	}
	
	show_debug_message("account_action: " + msg)
	instance_create_layer(room_width / 2, room_height / 4, "Instances", obj_action_announcement, {
		action_msg: msg,
		is_error: is_error
	})
}
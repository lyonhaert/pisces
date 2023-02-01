/// @description
mod_shift = keyboard_check(vk_shift)
mod_ctrl = keyboard_check(vk_control)

with (obj_text_field) {
	if focused {
		num_repeats = 0
		return
	}
}

var pressed_key = string(keyboard_lastkey)
//show_debug_message("pressed_key: " + pressed_key + " -- misc: " + chr(vk_EqualPlus) + chr(vk_numpad0) + chr(vk_numpad9))

// Key is 0-9:
var lc = ord(keyboard_lastchar)

if lc >= 48 && lc <= 57 {
	num_repeats *= 10
	num_repeats += lc - 48
	num_repeats = min(1000000, num_repeats)
	numinput_countdown_ms = numinput_clear_time_ms
	return
}

//num_times = max(1,  min(100, num_repeats));
num_times = max(1, num_repeats)
num_repeats = 0

// Find the event:
var event_def = events[$ pressed_key]
if event_def == undefined return;

evHandler_begin_handling(event_def, num_times, mod_shift, mod_ctrl)

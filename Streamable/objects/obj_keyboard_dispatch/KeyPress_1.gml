/// @description
mod_shift = keyboard_check(vk_shift)
mod_ctrl = keyboard_check(vk_control)

with (obj_text_field) {
	if focused {
		num_repeats = 0
		return
	}
}

var lk = keyboard_lastkey
var pressed_key = string(lk)
show_debug_message("keyboard_lastkey: " + pressed_key + "; keyboard_lastchar: " + keyboard_lastchar + " ord: " + string(ord(keyboard_lastchar)))

// Key is 0-9:
if lk > 95 && lk < 106 {
	lk -= 48
}

if lk > 47 && lk < 58 {
	num_repeats *= 10
	num_repeats += lk - 48
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

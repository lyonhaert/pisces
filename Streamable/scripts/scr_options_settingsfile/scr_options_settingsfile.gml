function ini_b2str(flag) { return flag ? "true" : "false"; }

function load_settings_ini() {
	ini_open("settings.ini");
	obj_options.draw_on_turn = bool(ini_read_string("behavior", "draw_on_turn", obj_options.draw_on_turn));
	obj_options.deselect_after_tap = bool(ini_read_string("behavior", "deselect_after_tap", obj_options.deselect_after_tap));
	obj_options.deselect_after_drag = bool(ini_read_string("behavior", "deselect_after_drag", obj_options.deselect_after_drag));
	ini_close();
}

function save_settings_ini() {
	ini_open("settings.ini");
	ini_write_string("behavior", "draw_on_turn", ini_b2str(obj_options.draw_on_turn));
	ini_write_string("behavior", "deselect_after_tap", ini_b2str(obj_options.deselect_after_tap));
	ini_write_string("behavior", "deselect_after_drag", ini_b2str(obj_options.deselect_after_drag));
	ini_close();
}

function subloadCustomKeybinds() {
	var binds = getDefaultKeybinds()
	
	var actions = variable_struct_get_names(defaultBinds)
	var len = array_length(actions)
	
	for (var i = 0; i < len; i++) {
		var name = actions[i]
		var newbind = ini_read_string("keybinds", name, "")
		if newbind != "" {
			var newcode = getCustomBindCode(newbind)
		}
	}
}

function getCustomBindCode(newbind) {
	newbind = string_upper(newbind)
	
	var nonAZ = getNonAlphaCodes()
	var code = 0
	
	if string_length(newbind) > 1 {
		code = nonAZ[$ newbind] ?? 0
	} else {
		code = ord(newbind)
	}
	
	return code
}

function getDefaultKeybinds() {
	return {
		"coalesce": ord("Q"),
		"draw": ord("D"),
		"mill": ord("M"),
		"scry": ord("R"),
		"deck_shuffle": ord("S"),
		"untap_all_new_turn": ord("N"),
		"counter_increment": [vk_add, vk_EqualPlus],
		"counter_decrement": [vk_subtract, vk_Minus],
		"card_clone": ord("Z"),
		"move_command_zone": ord("C"),
		"move_exile": ord("E"),
		"move_graveyard": ord("G"),
		"move_hand": ord("H"),
		"move_top_deck": ord("J"),
		"move_bottom_deck": ord("K"),
		"card_delete": ord("X"),
		"card_tap": ord("T"),
		"card_flip": ord("F"),
		"card_token": ord("B"),
	}
}

function getNonAlphaCodes() {
	return {
		"LEFT": vk_left,
		"RIGHT": vk_right,
		"UP": vk_up,
		"DOWN": vk_down,
		"ENTER": vk_enter,
		//"ESCAPE": vk_escape,
		"SPACE": vk_space,
		"BACKSPACE": vk_backspace,
		//"TAB": vk_tab,
		"HOME": vk_home,
		"END": vk_end,
		"DELETE": vk_delete,
		"INSERT": vk_insert,
		//"PAGEUP": vk_pageup,
		//"PAGEDOWN": vk_pagedown,
		"PAUSE": vk_pause,
		"PRINTSCREEN": vk_printscreen,
		//"F1": vk_f1,
		"F2": vk_f2,
		"F3": vk_f3,
		"F4": vk_f4,
		"F5": vk_f5,
		"F6": vk_f6,
		"F7": vk_f7,
		"F8": vk_f8,
		"F9": vk_f9,
		"F10": vk_f10,
		"F11": vk_f11,
		"F12": vk_f12,
		"MULTIPLY": vk_multiply,
		"DIVIDE": vk_divide,
		"ADD": vk_add,
		"SUBTRACT": vk_subtract,
		"DECIMAL": vk_decimal,
	}
}
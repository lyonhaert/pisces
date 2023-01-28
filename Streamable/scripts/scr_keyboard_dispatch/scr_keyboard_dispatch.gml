

function KeybindBuilder(_keybinds, _events) constructor {
	keybinds = _keybinds
	events = _events
	
	static AddBind = function(name, key, handler = noop, cardFilters = obj_keyboard_dispatch.emptyFilter) {
		var sKey = string(key)
		keybinds[$ name] = sKey
		events[$ sKey] = new KeybindHandler(name, handler, cardFilters)
	}
}

function KeybindHandler(_name, _eventHandler, _cardFilters) constructor {
	name = _name
	eventHandler = _eventHandler
	cardFilters = _cardFilters ?? emptyFilter
}

function evHandler_begin_handling(event_def, num_repeats, mod_shift, mod_ctrl) {
	switch (event_def.name) {
		case "coalesce":
			handle_user_event_based(event_def, 1)
			break
		case "draw":
		case "mill":
		case "scry":
			handle_user_event_based(event_def, num_repeats)
			break
		
		default:
			var cardInstances = find_selected_cards(event_def.cardFilters)
			if array_length(cardInstances) > 0 {
				//array_foreach(cardInstances, clear_menus)
				event_def.eventHandler(cardInstances, num_repeats, mod_shift, mod_ctrl)
			}
			break
	}
}

function handle_user_event_based(event_def, num_repeats) {
	var subscribers = find_message_subscribers(event_def.name)
	for (var i = 0; i < array_length(subscribers); i++) {
		repeat (num_repeats) {
			with (subscribers[i].obj) {
				event_user(subscribers[i].ev)
			}
		}
	}
	
	var verb = ""
	switch (event_def.name) {
		case "draw":
			verb = "Drew"
			break
		case "mill":
			verb = "Milled"
			break
	}
	
	if verb != "" {
		announce_action(verb + " " + string(num_repeats) + " card" + (num_repeats == 1 ? "" : "s"))
	}
}

function find_selected_cards(filters) {
	var cards = []
	with (obj_card) {
		if filters[$ "altSelect"] ?? false {
			if !is_hovering && !is_selected continue;
		} else {
			if !is_hovering && (!is_selected || is_dragged) continue;
		}
		
		if (filters[$ "nonHiddenZone"] ?? false) &&
			parent_stack != noone && parent_stack.hidden_zone continue;
		
		if (filters[$ "battleField"] ?? false) &&
			parent_stack != noone continue;
		
		array_push(cards, self)
	}
	return cards
}

/*
function evHandler_draw(num_repeats) {
	//not used yet
}

function evHandler_mill(num_repeats) {
	//not used yet
}

function evHandler_scry(num_repeats) {
	//not used yet
}

function evHandler_coalesce(mod_shift, mod_ctrl) {
	//not used yet
}
*/

function evHandler_counter_increment(cardInstances, num_repeats) {
	array_foreach(cardInstances, method({n: num_repeats}, function(cardInst) {
		add_card_counters(cardInst, , n)
	}))
}

function evHandler_counter_decrement(cardInstances, num_repeats) {
	array_foreach(cardInstances, method({n: num_repeats}, function(cardInst) {
		sub_card_counters(cardInst, , n)
	}))
}

function evHandler_card_clone(cardInstances, num_repeats) {
	array_foreach(cardInstances, method({n: num_repeats}, function(cardInst) {
		repeat (n) { duplicate_card(cardInst) }
	}))
}

function evHandler_move_command_zone(cardInstances) {
	array_foreach(cardInstances, move_to_command)
	announce_action(string(array_length(cardInstances)) + " moved to command zone")
}

function evHandler_move_exile(cardInstances) {
	array_foreach(cardInstances, move_to_exile)
	announce_action(string(array_length(cardInstances)) + " moved to exile")
}


function evHandler_move_graveyard(cardInstances) {
	array_foreach(cardInstances, move_to_graveyard)
	announce_action(string(array_length(cardInstances)) + " moved to graveyard")
}

function evHandler_move_hand(cardInstances) {
	array_foreach(cardInstances, move_to_hand)
	announce_action(string(array_length(cardInstances)) + " moved to hand")
}

function evHandler_move_top_deck(cardInstances, from_top) {
	if from_top > 1 && array_length(cardInstances) > 1 return;
	
	if from_top > 1 {
		add_to_card_stack_location(cardInstances[0], obj_deck, from_top - 1);
		announce_action("Moved to #" + string(from_top) + " from top of deck" )
	} else {
		array_foreach(cardInstances, move_to_deck_top)
		announce_action(string(array_length(cardInstances)) + " moved to top of deck")
	}
}

function evHandler_move_bottom_deck(cardInstances) {
	array_foreach(cardInstances, move_to_deck_bottom)
	announce_action(string(array_length(cardInstances)) + " moved to bottom of deck")
}

function evHandler_card_delete(cardInstances) {
	array_foreach(cardInstances, card_destroy)
	var n = array_length(cardInstances)
	announce_action(string(n) + " object" + (n == 1 ? "" : "s") + " removed")
}

function evHandler_card_tap(cardInstances) {
	array_foreach(cardInstances, tap_card)
}

function evHandler_card_flip(cardInstances, unused_count, mod_shift) {
	array_foreach(cardInstances, mod_shift ? toggle_upsidedown_card : flip_card)
}

function rcMenuBindSim(name) {
	var code = obj_keyboard_dispatch.keybinds[$ name]
	keyboard_key_press(code)
	keyboard_key_release(code)
}
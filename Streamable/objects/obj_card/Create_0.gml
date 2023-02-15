offset_drag = false;
drag_start_zone = noone;

is_tapping = false;
tapped = false;
tap_angle_percentage = 0;

next_x = x
next_y = y

x_vel = 0;
y_vel = 0;

skew_x = 0;
skew_y = 0;

parent_stack = noone;

image_xscale = obj_options.default_scaling;
image_yscale = obj_options.default_scaling;
time_hovering = 0;

offset_x = x;
offset_y = y;

counters = {
	"default": 0,
}

countersOtherNames = []

countersDefaultName = "counters"
if cardinfo.type_lookup[$ "Creature"] {
	countersDefaultName = "+1/+1"
} else if cardinfo.type_lookup[$ "Planeswalker"] {
	countersDefaultName = "Loyalty"
}

counterSize = 20;

my_submenu = new RightClickMenu();
my_partsmenu = new RightClickMenu();

var to_hand = new RightClickMenuOption("Hand", function(){rcMenuBindSim("move_hand")}, noop, noop, spr_hand, "H");
var to_top = new RightClickMenuOption("Top of Library", function(){rcMenuBindSim("move_top_deck")}, noop, noop, spr_book, "J");
var to_bottom = new RightClickMenuOption("Bottom of Library", function(){rcMenuBindSim("move_bottom_deck")}, noop, noop, spr_book_bookmark, "K");
var to_graveyard = new RightClickMenuOption("Graveyard", function(){rcMenuBindSim("move_graveyard")}, noop, noop, spr_skull_crossbones, "G");
var to_exile = new RightClickMenuOption("Exile", function(){rcMenuBindSim("move_exile")}, noop, noop, spr_exile, "E");
var to_command = new RightClickMenuOption("Command Zone", function(){rcMenuBindSim("move_command_zone")}, noop, noop, spr_crown, "C");
my_submenu.AddOption(to_hand);
my_submenu.AddOption(to_top);
my_submenu.AddOption(to_bottom);
my_submenu.AddOption(to_graveyard);
my_submenu.AddOption(to_exile);
my_submenu.AddOption(to_command);

var tap = new RightClickMenuOption("Tap", function(){rcMenuBindSim("card_tap")}, noop, noop, spr_tap, "T");
var flip = new RightClickMenuOption("Flip", function(){rcMenuBindSim("card_flip")}, noop, noop, spr_flip, "F");
var send_to = new RightClickSubMenu("Send To", my_submenu, spr_envelope, ">");
var duplicate = new RightClickMenuOption("Duplicate", function(){rcMenuBindSim("card_clone")}, noop, noop, spr_copy, "Z");
var note = new RightClickMenuOption("Update Note", update_note, noop, noop, spr_note_sticky);
//var spawn = new RightClickMenuOption("Make Spawner", create_spawner, noop, noop);
var add_counter = new RightClickMenuOption("Add Counter", function(){rcMenuBindSim("counter_increment")}, noop, noop, spr_counter_add, "+");
var rem_counter = new RightClickMenuOption("Remove Counter", function(){rcMenuBindSim("counter_decrement")}, noop, noop, spr_counter_rem, "-");
var clear_counters = new RightClickMenuOption("Clear Counters", clear_selected_cards_counters, noop, noop, spr_counter_rem)
clear_counters.draw_color = c_red
var toggle_token = new RightClickMenuOption("Toggle Token", function(){rcMenuBindSim("card_token")}, noop, noop, spr_shapes, "B");
var destroy = new RightClickMenuOption("Delete", function(){rcMenuBindSim("card_delete")}, noop, noop, spr_trash, "X");
destroy.draw_color = c_red;

var openScryfall = function() {	url_open(cardinfo.scryfall_uri) }
var scryfallOption = new RightClickMenuOption("Scryfall page", openScryfall, noop, noop, spr_envelope)

my_menu = new RightClickMenu();
my_menu.AddOption(tap);
my_menu.AddOption(flip);
my_menu.AddSeparator();
my_menu.AddOption(duplicate);


if array_length(all_parts) > 0 {
	for (var i = 0; i < array_length(all_parts); i++) {
		var curr_card = all_parts[i];
		
		var func = method(curr_card, function(card_inst) {
			instance_create_layer(
				card_inst.x + card_inst.sprite_width / 9,
				card_inst.y + card_inst.sprite_height / 9,
				"Instances",
				obj_id_request,
				{
					"req": self.internal_id,
					"spawn_number": 1,
					"as_tokens": true
				})
		})
		var menu_opt = new RightClickMenuOption(curr_card.internal_name, func, noop, noop, spr_shapes);
		my_partsmenu.AddOption(menu_opt)
	}
	
	var create_parts = new RightClickSubMenu("Tokens", my_partsmenu, spr_shapes, ">");
	create_parts.draw_color = c_yellow;
	
	my_menu.AddOption(create_parts);
}

my_menu.AddSeparator();
my_menu.AddOption(note);
my_menu.AddOption(add_counter);
my_menu.AddOption(rem_counter);
my_menu.AddOption(clear_counters)
//my_menu.AddOption(spawn);
my_menu.AddSeparator();
my_menu.AddOption(send_to);
my_menu.AddOption(toggle_token);
my_menu.AddOption(destroy);
my_menu.AddSeparator()
my_menu.AddOption(scryfallOption)

height_priority = next_height_priority();
owning_canvas = noone;

current_menu = noone;

save_struct = undefined;

default_subbed_events = {}

during_drag_events = {
	"coalesce": 0
};

subscribed_events = default_subbed_events;

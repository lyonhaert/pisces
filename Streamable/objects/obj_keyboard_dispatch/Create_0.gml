#macro vk_EqualPlus 187
#macro vk_Minus 189

mod_shift = false
mod_ctrl = false

keybinds = {}
events = {}

builder = new KeybindBuilder(keybinds, events)

/*
rought example result structure:

event name to keybind (to later to allow custom binding through settings, by name)
keybind[$ "draw"] = string(ord("D"))
 
events[$ keybind[$ "draw"]] = {
	name: "draw",
	eventHandler: evHandler_draw
}
*/

battlefieldFilter = {battleField: true}
nonHiddenFilter = {nonHiddenZone: true}
altSelectFilter = {altSelect: true}
emptyFilter = {}

keyboard_set_map(ord("W"), ord("T"))

//this group still uses the user event + subscriber search model
builder.AddBind("draw", ord("D"))
builder.AddBind("mill", ord("M"))
builder.AddBind("scry", ord("R"))
builder.AddBind("coalesce", ord("Q"))

// these use selected/hovered cards search and num_repeats
builder.AddBind("counter_increment", vk_add, evHandler_counter_increment, nonHiddenFilter)
builder.AddBind("counter_increment", vk_EqualPlus, evHandler_counter_increment, nonHiddenFilter)
builder.AddBind("counter_decrement", vk_subtract, evHandler_counter_decrement, nonHiddenFilter)
builder.AddBind("counter_decrement", vk_Minus, evHandler_counter_decrement, nonHiddenFilter)
builder.AddBind("card_clone", ord("Z"), evHandler_card_clone)

// these just use selected/hovered cards search
builder.AddBind("move_command_zone", ord("C"), evHandler_move_command_zone)
builder.AddBind("move_exile", ord("E"), evHandler_move_exile)
builder.AddBind("move_graveyard", ord("G"), evHandler_move_graveyard)
builder.AddBind("move_hand", ord("H"), evHandler_move_hand)
builder.AddBind("move_top_deck", ord("J"), evHandler_move_top_deck)
builder.AddBind("move_bottom_deck", ord("K"), evHandler_move_bottom_deck)
builder.AddBind("card_delete", ord("X"), evHandler_card_delete)

builder.AddBind("card_tap", ord("T"), evHandler_card_tap, battlefieldFilter)

builder.AddBind("card_flip", ord("F"), evHandler_card_flip, altSelectFilter)



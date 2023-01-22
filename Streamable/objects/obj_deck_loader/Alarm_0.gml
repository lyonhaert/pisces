/// @description Begin Next Card

var loadData = array_pop(cardsToLoad)

if loadData == undefined {
	alarm[0] = -1
	instance_destroy()
	return
}

//instance_create_layer(x, y, "Instances", obj_card_request, loadData)
show_debug_message(string(loadData))

alarm[0] = alarmTiming

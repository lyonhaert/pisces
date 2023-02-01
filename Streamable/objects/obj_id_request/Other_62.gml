var success = card.HandleDataPopulation()

if (!success) {
	show_debug_message("Error");
	instance_destroy();
	return;
}

if (card.CanCreate())
{
	var new_card = card.Create(x, y, 1)[0];
	new_card.is_revealed = true;
	new_card.is_token = as_tokens;
	instance_destroy();
}
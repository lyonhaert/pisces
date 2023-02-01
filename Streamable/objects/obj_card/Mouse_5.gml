/// @description Right Pressed
if not is_hovering return;

clear_all_menus();

if parent_stack == noone
{
	current_menu = my_menu.CreateMenu(mouse_x + 15, mouse_y, self);
}

if parent_stack == obj_scry
{
	current_menu = my_submenu.CreateMenu(mouse_x + 15, mouse_y, self);	
}
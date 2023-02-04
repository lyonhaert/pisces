
function any_stack_active(){
	return find_active_stack() != noone;
}

function find_active_stack() {
	with (obj_vertical_stack)
	{
		if (active) return self;	
	}
	
	return noone;
}

function swap_stack_visibility(targetStack, activeStack){
	///start by swapping the contents of the two stacks
	tempStackX = targetStack.x;
	targetStack.x = activeStack.x;
	activeStack.x = tempStackX;

	tempActiveState = targetStack.active;
	targetStack.active = activeStack.active;
	activeStack.active = tempActiveState

}

/// @description Insert description here
// You can write your code in this editor

if mouse_check_button_pressed(mb_left) {
	if oWorld.selected == sTownHall {
		var box = instance_create_layer(mouse_x, mouse_y - 16, "Instances", oTextbox)
		box.text = "Right click to place your town hall first!"	
		box.x = room_width/2-30
		box.y = room_height/2
		exit
	}
	if oWorld.selected != sprite oWorld.selected = sprite
	else oWorld.selected = noone
}
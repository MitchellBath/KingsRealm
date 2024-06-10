/// @description Insert description here
// You can write your code in this editor


if position_meeting(mouse_x, mouse_y, self) {
	sprite_index = sUndoSelected 
	var textbox = instance_create_layer(mouse_x - 500, mouse_y, "GUI", oTextbox)
	textbox.text = "Undo your last placement"
	textbox.alarm[0] = 2
}else sprite_index = sUndoUnselected
if position_meeting(mouse_x, mouse_y, self) and mouse_check_button(mb_left) sprite_index = sUndoClicked
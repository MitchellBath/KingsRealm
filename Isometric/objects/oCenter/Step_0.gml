/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
	sprite_index = sCompassSelected 
	var textbox = instance_create_layer(mouse_x - 500, mouse_y, "GUI", oTextbox)
	textbox.text = "Center your realm"
	textbox.alarm[0] = 2
}else sprite_index = sCompassUnselected
if position_meeting(mouse_x, mouse_y, self) and mouse_check_button(mb_left) sprite_index = sCompassClicked
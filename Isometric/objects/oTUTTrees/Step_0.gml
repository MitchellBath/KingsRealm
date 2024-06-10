/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 500, mouse_y, "GUI", oTextbox)
	textbox.text = "Natural obstacles block placements"
	textbox.alarm[0] = 2	
}
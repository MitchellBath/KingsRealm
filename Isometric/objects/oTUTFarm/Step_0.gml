/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "Farms generate food.\nThey are better on grass and even better on fertile land!"
	textbox.alarm[0] = 2	
}
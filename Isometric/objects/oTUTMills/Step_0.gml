/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "Mills generate extra labor\nThey are better on sand, and even better on sand gems!\nMill cost increases with each mill placed\nThe King recommends building a mill during Year One!"
	textbox.alarm[0] = 2	
}
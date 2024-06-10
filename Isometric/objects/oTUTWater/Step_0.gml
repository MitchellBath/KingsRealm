/// @description Insert description here
// You can write your code in this editor


if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "Only roads can be built on water\nBut they help prevent fire for adjacent buildings!"
	textbox.alarm[0] = 2	
}
/// @description Insert description here
// You can write your code in this editor


if room == Title and position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 400, mouse_y, "Instances", oTextbox)
	textbox.text = "Click for Tutorial"
	textbox.alarm[0] = 2	
}

if room == Tutorial and position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 400, mouse_y, "Instances", oTextbox)
	textbox.text = "Back to Title"
	textbox.alarm[0] = 2	
}

if room == Tutorial sprite_index = sBackButton
if room == Title sprite_index = sTutorial
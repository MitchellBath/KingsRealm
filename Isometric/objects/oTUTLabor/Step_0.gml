/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 400, mouse_y, "GUI", oTextbox)
	textbox.text = "Labor is spent to build new buildings\nBuilding cost varies by year, check the value below each button!"
	textbox.alarm[0] = 2	
}
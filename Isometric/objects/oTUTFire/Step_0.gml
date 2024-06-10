/// @description Insert description here
// You can write your code in this editor


if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 1000, mouse_y, "GUI", oTextbox)
	textbox.text = "Houses AND farms can catch and spread fire\nAdjacent buildings increase the chance of fire\nAdjacent flaming buildings greatly increase the chance of fire!\nBurnt buildings take two years to clear up"
	textbox.alarm[0] = 2	
}
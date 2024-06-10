/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 500, mouse_y, "GUI", oTextbox)
	textbox.text = "Population is your score and generated from houses\nPopulation can never be higher than your food!"
	textbox.alarm[0] = 2	
}
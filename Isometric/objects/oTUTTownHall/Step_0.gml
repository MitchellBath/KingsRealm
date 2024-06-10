/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "The Town Hall must be placed first\nIt's the biggest tile at a whopping 2x2 size\nBuildings must be connected to the Town Hall via any road to generate benefits!"
	textbox.alarm[0] = 2	
}
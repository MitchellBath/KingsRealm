/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "Roads connect buildings to the town hall. They cannot burn or be destroyed.\nBuildings not connected by a road to the Town Hall do not generate resources!"
	textbox.alarm[0] = 2	
}
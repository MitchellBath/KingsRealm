/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "Left click and drag to move around\nScroll in/out to zoom\nLeft click buttons to select and interact\nRight click while a button is selected to place the building\nESC to back out or quit!"
	textbox.alarm[0] = 2	
}
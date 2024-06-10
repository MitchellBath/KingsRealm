/// @description Insert description here
// You can write your code in this editor
if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 600, mouse_y, "GUI", oTextbox)
	textbox.text = "Meet the population quota by the deadline or it's game over\nMeeting the quota adds 4 years to the deadline and increases the quota\nIt also expands your realm!"
	textbox.alarm[0] = 2	
}
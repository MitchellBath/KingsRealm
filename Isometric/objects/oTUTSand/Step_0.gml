/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "Sand benefits mills but creates fire risk for houses and farms.\nObstacles are less plentiful; enjoy the space!"
	textbox.alarm[0] = 2	
}
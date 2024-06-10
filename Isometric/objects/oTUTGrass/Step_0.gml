/// @description Insert description here
// You can write your code in this editor

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
	textbox.text = "Grass is great for building! Especially for farms and houses!"
	textbox.alarm[0] = 2	
}

if keyboard_check_pressed(vk_escape) room_goto(Title)
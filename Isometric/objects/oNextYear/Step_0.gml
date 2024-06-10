/// @description Insert description here
// You can write your code in this editor


if position_meeting(mouse_x, mouse_y, self) {
	sprite_index = sPlayButtonSelected
	var textbox = instance_create_layer(mouse_x - 600, mouse_y, "GUI", oTextbox)
	textbox.text = "Advance one year (unspent labor lost!)"
	textbox.alarm[0] = 2
}else sprite_index = sPlayButtonUnselected
if position_meeting(mouse_x, mouse_y, self) and mouse_check_button(mb_left) sprite_index = sPlayButtonClicked
if !active sprite_index = sPlayButtonUnselected
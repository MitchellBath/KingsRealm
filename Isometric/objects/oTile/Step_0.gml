/// @description Insert description here
// You can write your code in this editor

if ontop != noone{
	subframe+=1
	if subframe == sprite_get_speed(ontop) {
		frame +=1
		subframe = 0
	}
	if frame == sprite_get_number(ontop) frame = 0
}

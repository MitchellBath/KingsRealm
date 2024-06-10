/// @description Insert description here
// You can write your code in this editor

draw_self()
if position_meeting(mouse_x, mouse_y, self) {
	draw_sprite_ext(sCreditPage, -1, (room_width)/2, room_height/2, 4, 4, 0, c_white, 1)
}
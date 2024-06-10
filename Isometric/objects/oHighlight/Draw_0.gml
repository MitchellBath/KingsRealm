/// @description Insert description here
// You can write your code in this editor
draw_self()
if mytile != noone {
	draw_sprite_ext(mytile.sprite_index, mytile.image_index, x, y, 2, 2, 0, c_white, 1) //tile
	if mytile.ontop != noone {
		if mytile.animatedtop and mytile.ontop != sTownHall and mytile.ontop != sTownHallB draw_sprite_ext(mytile.ontop, mytile.frame, x, y-sprite_get_height(mytile.sprite_index), 2, 2, 0, mytile.color, 1)
		else if mytile.ontop == sRoads draw_sprite_ext(mytile.ontop, mytile.roadsub, x, y-sprite_get_height(mytile.sprite_index), 2, 2, 0, mytile.color, 1)
		else if mytile.ontop == sTownHall or mytile.ontop == sTownHallB or mytile.ontop == sEmptyTile draw_sprite_ext(sTownHallFULL, mytile.randomval%sprite_get_number(sTownHallFULL), x, y-sprite_get_height(mytile.sprite_index), 2, 2, 0, mytile.color, 1)
		else draw_sprite_ext(mytile.ontop, mytile.randomval%sprite_get_number(mytile.ontop), x, y-sprite_get_height(mytile.sprite_index), 2, 2, 0, mytile.color, 1)
	}
}

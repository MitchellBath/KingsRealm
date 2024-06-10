/// @description Insert description here
// You can write your code in this editor

// dropping
if alarm[0]*3 > -1{
	//randomval%sprite_get_number(sprite_index)
	draw_sprite_ext(sprite_index, -1, x, y-alarm[0]*3*1.5, oWorld.zoom, oWorld.zoom, 0, c_white, 1) // drop animation
	if ontop != noone {
		if animatedtop draw_sprite_ext(ontop, frame, x, y-sprite_height/2-alarm[0]*3*1.5, image_xscale, image_yscale, 0, color, 1)
		else if ontop == sRoads draw_sprite_ext(ontop, roadsub, x, y-sprite_height/2-alarm[0]*3*1.5, image_xscale, image_yscale, 0, color, 1)
		else draw_sprite_ext(ontop, randomval%sprite_get_number(ontop), x, y-sprite_height/2-alarm[0]*3*1.5, image_xscale, image_yscale, 0, color, 1)
	}
	
}

// not dropping
else {
	draw_self()
	if ontop != noone {
		if animatedtop draw_sprite_ext(ontop, frame, x, y-sprite_height/2, image_xscale, image_yscale, 0, color, 1)
		else if ontop == sRoads draw_sprite_ext(ontop, roadsub, x, y-sprite_height/2, image_xscale, image_yscale, 0, color, 1)
		else draw_sprite_ext(ontop, randomval%sprite_get_number(ontop), x, y-sprite_height/2, image_xscale, image_yscale, 0, color, 1)
	}
}
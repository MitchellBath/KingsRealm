/// @description Insert description here
// You can write your code in this editor
randomval = irandom_range(0, 100)
animatedtop = false
frame = 0
subframe = 0
ontop = noone
structure = false
roadsub = 0

color = c_white

//alarm[0] = room_speed/10 // slow descent

//if irandom_range(0,1) == 0 sprite_index = sRockTile else sprite_index = sTile

if room == Title {
	randomize()
	switch irandom_range(0, 3) {
		case 0: sprite_index = sTile
		break
		case 1: sprite_index = sTileSand
		break
		case 2: sprite_index = sTileWater
		break
		case 3: sprite_index = sTileGems
		break
		default: sprite_index = sTile
		break
	}
	if sprite_index == sTile and irandom_range(0, 1)==0 ontop = sTrees
	if sprite_index == sTileSand and irandom_range(0, 1)==0 ontop = sDesertDecorations
	
	if sprite_index == sTile or sprite_index == sTileSand {
		if irandom_range(0, 2) == 0 ontop = sHouseVariants
	}
	
	image_index = irandom_range(0, sprite_get_number(sprite_index))
	
	audio_stop_all()
	var audiotheme = audio_play_sound(theme4, 10, true)
	audio_sound_gain(audiotheme, 0.2, 0)
}
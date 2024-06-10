/// @description Insert description here
// You can write your code in this editor


if mouse_check_button_pressed(mb_left) {
	//oWorld.world = oWorld.prevworld
	var prev = oWorld.prevmove
	if prev.xx == -1 or prev.yy == -1 exit
	var tile = oWorld.world[prev.xx][prev.yy]
	if tile.ontop == sTownHall or tile.ontop == sTownHallB exit
	if inArray(oWorld.mills, oWorld.world[prev.xx][prev.yy].ontop) oWorld.costs[2][1] -= 7
	tile.ontop = noone
	tile.structure = false
	tile.animatedtop = false
	oWorld.labor += prev.lostlabor
	oWorld.prevmove = {
		xx : -1,
		yy : -1,
		lostlabor : 0
	}
	oWorld.updateRoads()
	audio_play_sound(undo, 11, false)
}
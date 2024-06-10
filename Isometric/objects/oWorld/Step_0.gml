/// @description Insert description here
// You can write your code in this editor

// bring her back
if x < -100*zoom*size or x > room_width + 100*zoom*size or y < -100*zoom*size or y > room_height + 100*zoom*size {
	x = room_width/2
	y = room_height/2
}

if basecoords[0] == -1 and basecoords[1] == -1 {
	selected = sTownHall // must place first
}

// zoom
if mouse_wheel_up() {
	zoom += .3
	redrawTiles()
}
if mouse_wheel_down() {
	zoom -= .3
	redrawTiles()
}
zoom = clamp(zoom, 1, 10)

// if zoomed, change zoom
if mouse_wheel_up() or mouse_wheel_down() {
	// scale tiles
	for (i = 0; i < size; i++) {
		for (k = 0; k < size; k++) {
		
			world[i][k].image_xscale = zoom
			world[i][k].image_yscale = zoom
		
		}
	}
}

// drag
//// redo
//if mouse_check_button(mb_left) {
//	camera_set_view_pos(view_camera[0],oldx -(mouse_x - camera_get_view_x(view_camera[0])),oldy -(mouse_y - camera_get_view_y(view_camera[0])))
//	redrawTiles()
//}

if mouse_check_button_pressed(mb_left) {
	oldx = x - mouse_x
	oldy = y - mouse_y
}
if mouse_check_button(mb_left) {
	x = mouse_x + oldx
	y = mouse_y + oldy
	// refresh blocks
	redrawTiles()
}


// hover
var realcoords = projectback(mouse_x-x, mouse_y-y)
if realcoords[0] > -1 and realcoords[1] > -1 and realcoords[0] < size-1 and realcoords[1] < size-1{
	realcoords[0] = ceil(realcoords[0])
	realcoords[1] = ceil(realcoords[1])
	
	// for moving off tiles, avoid redraws
	if realcoords[0] != oldcoords[0] or realcoords[1] != oldcoords[1] redrawTiles()
	oldcoords[0] = realcoords[0]
	oldcoords[1] = realcoords[1]
	
	tile = world[realcoords[0]][realcoords[1]] // grab the tile in the world
	
	// redraw the tile
	tile.x = x + projectcoords(realcoords[0],realcoords[1])[0]
	tile.y = y + projectcoords(realcoords[0],realcoords[1])[1]
	tile.image_xscale = zoom
	tile.image_yscale = zoom
	tile.depth = tile.y*-0.2 + layer_get_depth("Instances") // minimum is -1080
	
	// make alt base tiles float too
	tile.y = y + projectcoords(realcoords[0],realcoords[1])[1] - floor(sin(current_time/100)*2*zoom) // float when hovering
	
	if basecoords[0] != -1 and basecoords[1] != -1 {
		if basecoords[0] == realcoords[0] and basecoords[1] == realcoords[1] { // if base
			for (var i = 0; i < array_length(altbasecoords); i++) {
				var temptile = world[altbasecoords[i][0]][altbasecoords[i][1]]
				temptile.y = y + projectcoords(altbasecoords[i][0], altbasecoords[i][1])[1] - floor(sin(current_time/100)*2*zoom) // float when hovering
			}
		}
		else {
			for (var j = 0; j < array_length(altbasecoords); j++) {
				if altbasecoords[j][0] == realcoords[0] and altbasecoords[j][1] == realcoords[1] {// if around base
					print($"found {current_time}")
					for (var i = 0; i < array_length(altbasecoords); i++) {
						var temptile = world[altbasecoords[i][0]][altbasecoords[i][1]]
						// float all alt base tiles (except current selected, will float anyway) if altbasecoords[i][0] != realcoords[0] and altbasecoords[i][1] != realcoords[1] 
						temptile.y = y + projectcoords(altbasecoords[i][0], altbasecoords[i][1])[1] - floor(sin(current_time/100)*2*zoom)
					}
					var temptile = world[basecoords[0]][basecoords[1]]
					temptile.y = y + projectcoords(basecoords[0], basecoords[1])[1] - floor(sin(current_time/100)*2*zoom) // float base 
				}
			}
		}
	}
	
	oHighlight.mytile = tile // hover gui
	
	// add building
	if mouse_check_button_pressed(mb_right) {
		
		if irandom_range(0,1)==0 audio_play_sound(blip1, 11, false) else audio_play_sound(blip3, 11, false)
		
		if selected != noone and tile.ontop == noone and (selected == sRoads or tile.sprite_index != sTileWater) { // only roads go on water
			// check if they can afford it and charge them
			projected = 0
			for (var i = 0; i < array_length(costs); i++) {
				if costs[i][0] == selected {
					projected = costs[i][1]
					if tile.sprite_index == sTileWater projected += 4
					if labor < projected	exit // if they cant afford, stop running this step
					labor -= projected
					if selected == sMillVariant00 costs[i][1] += 7 // mills cost more after making one
				}
			}
			
			tile.structure = true
			// farm variants
			if selected == sFarm_Variant00 {
				selected = farms[irandom_range(0, array_length(farms)-1)]
				tile.animatedtop = true
				tile.ontop = selected
				selected = sFarm_Variant00
			// mill variants
			} else if selected == sMillVariant00 {
				selected = mills[irandom_range(0, array_length(mills)-1)]
				tile.animatedtop = true
				tile.ontop = selected
				selected = sMillVariant00
				
			} else if selected == sTownHall { // base placing four tiles at once code
				if realcoords[0]-1 >= 0 and realcoords[1]-1 >= 0 and basecoords[0] == -1 and basecoords[1] == -1 { // if we can place the base, and the first base
					tile2 = world[realcoords[0]-1][realcoords[1]] // left
					tile3 = world[realcoords[0]][realcoords[1]-1] // up
					tile4 = world[realcoords[0]-1][realcoords[1]-1] // upleft
					
					if tile.ontop == noone and tile2.ontop == noone and tile3.ontop == noone and tile4.ontop == noone  and tile.sprite_index != sTileWater and tile2.sprite_index != sTileWater and tile3.sprite_index != sTileWater and tile4.sprite_index != sTileWater {
						// if there are no structures in the way
						
						// base hovering
						array_push(altbasecoords, [realcoords[0]-1, realcoords[1]])
						array_push(altbasecoords, [realcoords[0], realcoords[1]-1])
						array_push(altbasecoords, [realcoords[0]-1, realcoords[1]-1])
						
						tile.structure = true
						tile2.structure = true
						tile3.structure = true
						tile4.structure = true

						tile.ontop = selected
						tile.animatedtop = true
						tile2.ontop = sEmptyTile
						tile3.ontop = sTownHallB
						tile3.animatedtop = true
						tile4.ontop = sEmptyTile
						basecoords = [realcoords[0], realcoords[1]]
				
						oWorld.selected = noone
						
					} else {
						tile.structure = false // fail
						var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
						textbox.text = "Not enough space! Needs 2x2 (click bottom tile)"
					}
						
				} else {
					tile.structure = false // fail
					var textbox = instance_create_layer(mouse_x, mouse_y, "GUI", oTextbox)
					textbox.text = "Out of bounds! Needs 2x2 (click bottom tile)"
				}
			} else 	{
				tile.ontop = selected
			}
			updateRoads()
			
			// set previous move, for undoing
			prevmove = {
				xx : realcoords[0],
				yy : realcoords[1],
				lostlabor : projected
			}
			
		}
	}
}
else {
	oHighlight.mytile = noone
	if !mouse_check_button(mb_left) redrawTiles()
}
if keyboard_check_pressed(vk_escape) room_goto(Title)
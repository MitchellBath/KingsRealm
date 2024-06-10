/// @description Insert description here
// You can write your code in this editor

randomize()
window_set_fullscreen(true)

world = []
prevmove = {
	xx : -1,
	yy : -1,
	lostlabor : 0
}
size = 1
selected = sTownHall
world[0][0] = instance_create_layer(0, 0, "Instances", oTile)
world[0][0].alarm[0] = 100
farms = [sFarm_Variant00, sFarm_Variant01, sFarm_Variant02, sFarm_Variant03, sFarm_Variant04]
mills = [sMillVariant00, sMillVariant01, sMillVariant02, sMillVariant03]
costs = [[sHouseVariants, 3], [sFarm_Variant00, 2], [sMillVariant00, 7], [sRoads, 1]]

// initialize
x = room_width/2
y = room_height/2

zoom = 1
year = 1
food = 0
population = 0
labor = 20
quota = 2
deadline = 5
basecoords = [-1, -1]
altbasecoords = []
expansions = 0
oldcoords = [-1,-1]
currentfires = 0

firerisk = 2

// world generation center points
centers = []
for (j = 0; j < 900; j++) {
	switch irandom_range(0,10) {
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
			array_push(centers, [irandom_range(-100, 100),irandom_range(-100, 100), sTile])
			break
		case 7:
		case 8:
			array_push(centers, [irandom_range(-100, 100),irandom_range(-100, 100), sTileSand])
			break
		case 9:
		case 10:
			array_push(centers, [irandom_range(-100, 100),irandom_range(-100, 100), sTileWater])
			break
		default:
			break
	}
}
array_push(centers, [0,0, sTile]) // default to grass

function projectcoords(xx, yy) {
	coords = []
	
	w = world[0][0].sprite_width/2
	h = world[0][0].sprite_height/2
	
	array_push(coords, xx*w		+ yy*-1*w)
	array_push(coords, xx*0.5*h + yy*0.5*h)
	return coords
}
// invert a matrix, for projecting back to real coords
function matrixInvert(a,b,c,d){
    det = (1/(a*d-b*c))
    inverted = []
	array_push(inverted, det*d)
	array_push(inverted, det*-b)
	array_push(inverted, det*-c)
	array_push(inverted, det*a)
    return inverted
}
// project isometric coordinates to real coordinates
function projectback(xx, yy) {
	coords = []
	
	w = world[0][0].sprite_width/2
	h = world[0][0].sprite_height/2
	
	inverted = matrixInvert(w,-w,0.5*h,0.5*h)
	
	array_push(coords, xx*inverted[0]	+ yy*inverted[1])
	array_push(coords, xx*inverted[2]	+ yy*inverted[3])
	return coords
}
// set real x/y vals
function redrawTiles() {
	for (i = 0; i < size; i++) {
		for (k = 0; k < size; k++) {
			// project tiles
			world[i][k].x = x + projectcoords(i,k)[0]
			world[i][k].y = y + projectcoords(i,k)[1]
			world[i][k].image_xscale = zoom
			world[i][k].image_yscale = zoom
			world[i][k].depth = world[i][k].y*-0.2 + layer_get_depth("Instances") // minimum is -1080
		}
	}
}

function updateRoads() {
	for (var i = 0; i < size; i++) {
		for (var k = 0; k < size; k++) {
			var tile = world[i][k]
			var up = false
			var down = false
			var left = false
			var right = false
			var xx = i
			var yy = k
				
			//check up
			if yy-1 >= 0 and world[xx][yy-1].structure up = true
			//check down
			if yy+1 < size and world[xx][yy+1].structure down = true
			//check left
			if xx-1 >= 0 and world[xx-1][yy].structure left = true
			//check right
			if xx+1 < size and world[xx+1][yy].structure right = true
				
			// give sprite
			subimage = 0
				
			// fuck this part in particular
			if !up and !down and !left and !right subimage = 0 //dot
			if up and down and left and right subimage = 1 // cross
			if !up and down and left and right subimage = 2 // T
			if up and down and right and !left subimage = 3 // T flat facing left
			if up and left and right and !down subimage = 4 // upside down T
			if up and left and down and !right subimage = 5 // flat T facing right
			if left and right and !up and !down subimage = 6 // horizontal line
			if up and down and !left and !right subimage = 7 // vertical line
			if right and down and !up and !left subimage = 8 // upleft L
			if up and right and !down and !left subimage = 9 // L
			if left and down and !up and !right subimage = 10 // left down L
			if left and up and !down and !right subimage = 11 // backwards L
			if down and !up and !left and !right subimage = 12 // deadend from bottom
			if right and !up and !down and !left subimage = 13 // deadend from right
			if up and !down and !left and !right subimage = 14 // deadend from top
			if left and !down and !up and !right subimage = 15 //deadend from left
				
			tile.roadsub = subimage	
		}
	}
	
}


function destroyWorld() {
	for (var i = 0; i < array_length(world); i++) {
		for (k = 0; k < array_length(world); k++) {
			instance_destroy(world[i][k])
		}
	}
}

function isConnected(x1, y1) {
	if basecoords == [-1,-1] return false
	return dfs(x1,y1,basecoords[0], basecoords[1], true)
}

function nextYear() {
	// loop all tiles, give food
	var timer = current_time
	var loader = instance_create_layer(room_width/2, room_height/2, "GUI", oLoading)
	year += 1
	labor = 5 // free from base
	population = 0
	food = 0
	currentfires = 0
	prevmove = { // reset undo button
		xx : -1,
		yy : -1,
		lostlabor : 0
	}
	for (var i = 0; i < array_length(world); i++) {
		for (var k = 0; k < array_length(world); k++) {
			tile = world[i][k]
			// remove fires and plagues
			if tile.ontop == sFarmAshes02 or tile.ontop == sHouseAshes02 {
					tile.ontop = noone
					tile.structure = false
					tile.animatedtop = false
					tile.frame = 0
					tile.subframe = 0
					tile.roadsub = 0
					tile.color = c_white
				}
			if tile.ontop == sHouseAshes01 tile.ontop = sHouseAshes02
			if tile.ontop == sHouseFire tile.ontop = sHouseAshes01
			if tile.ontop == sFarmAshes01 tile.ontop = sFarmAshes02
			if tile.ontop == sFarmFire tile.ontop = sFarmAshes01
				
			if tile.structure {
				// give the goodies but only if they are connected to the base
				tile.color = c_white
				if isConnected(i,k) {
					if inArray(farms, tile.ontop) != -1 {
						food += 1
						if tile.sprite_index == sTile food += 2
						if tile.sprite_index == sTileFertile food += 5
						n = neighbors({xx : i, yy : k, camefrom: noone, cost: 0}, 0, 0)
					}
					if tile.ontop == sHouseVariants {population += 1 labor += 1}
					if inArray(mills, tile.ontop) != -1 {
						labor += 4
						if tile.sprite_index == sTileSand labor += 5
						if tile.sprite_index == sTileGems labor += 6
					}
				}
				else tile.color = c_red // unconnected tiles go red
				
				// give the baddies
				// fire
				var risk = 100-firerisk
				if inArray(farms, tile.ontop) or tile.ontop == sHouseVariants{
					n = neighbors({xx: i, yy : k, camefrom : noone, cost: 0}, i, k)
					for (var p = 0; p < array_length(n); p++) {
						var othertile = world[n[p].xx][n[p].yy]
						var othertiletop = othertile.ontop
						if  othertiletop == sHouseVariants or inArray(farms, othertiletop) risk -= firerisk // adjacent buildings, cept mills, add risk
						if  othertiletop == sFarmFire or othertiletop == sHouseFire risk -= firerisk*5 // if an adjacent building is on fire, add tons of risk
						risk -= floor((year+1) div 2) // year risk
						if othertile.sprite_index == sTileWater risk += firerisk*4 // water safer
					}
					if tile.sprite_index == sTileSand risk -= firerisk*3 // sand risk
					risk = clamp(risk, 0, 10000)
					if irandom_range(0, risk) == 0 {
						if tile.ontop == sHouseVariants	{
							tile.ontop = sHouseFire
							tile.animatedtop = true
							currentfires++
						}
						if inArray(farms, tile.ontop) {
							tile.ontop = sFarmFire
							tile.animatedtop = true
							currentfires++
						}
					}
				}
			}
		}
	}
	// end of process
	population = clamp(population, 0, food)
	//labor = clamp(labor, 0, population)
	
	// hit quota
	if population >= quota {
		quota += floor(size/2 + 2)
		deadline += 4
		increaseSizeAll()
		if deadline <= 23 increaseSizeAll() // additional layers for first couple deadlines
		for (var k = 0; k < array_length(costs); k++) {
			if costs[k][0] == sFarm_Variant00 costs[k][1] += 1// farms cost one more per expansion
			if costs[k][0] == sHouseVariants costs[k][1] += 1// houses cost one more per expansion
			// farms cost one more on even expansions
			if costs[k][0] == sFarm_Variant00 and costs[k][1]%2==1 {
				for (var p = 0; p < array_length(costs); p++) {
					if costs[p][0] == sRoads costs[p][1] += 1 // roads cost one more per level up
				}
			}
		}
	}
	if deadline == year {
		oGameOver.populationscore = population
		oGameOver.yearscore = year
		room_goto(Results)
	}
	updateRoads()
	print($"took {current_time-timer} milliseconds")
	instance_destroy(loader)
}

function manhattanDistance(x1,y1,x2,y2) {
	return abs(x1-x2) + abs(y1-y2)
}
function closestCenter(xx,yy) {
	minimum = infinity // too high
	closest = sTile // default closest center
	for (var j = 0; j < array_length(centers); j++) {
		if abs(xx-centers[j][0]) + abs(yy-centers[j][1]) < minimum {
			minimum = abs(xx-centers[j][0]) + abs(yy-centers[j][1])
			closest = centers[j][2]
		}
	}
	return closest
}
// river generation
rivers = []
// place points, draw lines between them
// add to array of river tiles so that you can generate new tiles in rivers
function makeRiver(x1,y1,x2,y2) {
	currentx = x1
	currenty = y1
	array_push(rivers, [currentx, currenty])
	
	while currentx != x2 or currenty != y2{
		if irandom_range(0,1)==0 {
			currentx -= sign(currentx-x2)
		}
		else {
			currenty -= sign(currenty-y2)
		}
		array_push(rivers, [currentx, currenty])
	}
	return true
}

// make a river come out of every lake
for (var q = 0; q < array_length(centers); q++) {
	if centers[q][2] == sTileWater {
		for (var i = 0; i < irandom_range(0, 3); i++) makeRiver(centers[q][0] + irandom_range(-16, 16),centers[q][1] + irandom_range(-16, 16), centers[q][0], centers[q][1])
	}
}


/*
	path = dfs(x1,y1,x2,y2)
	if path == -1 {show_debug_message("could not find path") return false}
	while path.camefrom != noone {
		world[path.xx][path.yy].sprite_index = sTileWater
		path = path.camefrom
	}
	show_debug_message("completed!!!")
*/

// create world
/*
for (i = 0; i < size; i++) {
	for (k = 0; k < size; k++) {
		world[i][k] = instance_create_layer(i, k, "Instances", oTile)
		closest = closestCenter(i, k)
		// biome
		world[i][k].sprite_index = closest
		if closest == sTileSand {
			world[i][k].image_speed = 0
			world[i][k].image_index = irandom_range(0, sprite_get_number(sTileSand))
		}
		// river override
		if inArray(rivers, [i,k]) world[i][k].sprite_index = sTileWater
		world[i][k].alarm[0] += 4*i+k*4
		
		// random trees
		if irandom_range(0,7)==0 and world[i][k].sprite_index == sTile world[i][k].ontop = sTrees
		
	}
}
*/
// increase size of the grid by one column and row
function increaseSizeAll() {
	y -= zoom*sprite_get_height(sTile)/2
	newworld = []
	var oldsize = size
	size += 2
	expansions += 1
	// initialize the new world
	for (var i = 0; i < size; i++) {
		for (var k = 0; k < size; k++) {
			newworld[i][k] = undefined
		}
	}
	// grab old tiles
	for (var i = 1; i < oldsize+1; i++) {
		for (var k = 1; k < oldsize+1; k++) {
			newworld[i][k] = world[i-1][k-1]
		}
	}
	// refine base coords
	if basecoords[0] != -1 basecoords[0] += 1
	if basecoords[1] != -1 basecoords[1] += 1 // in case they have not placed it yet
	// refine alt base coords
	for (var i = 0; i < array_length(altbasecoords); i++) {
		altbasecoords[i][0] +=1	
		altbasecoords[i][1] +=1	
	}
	
	// generate new tiles
	for (var i = 0; i < size; i++) {
		for (var k = 0; k < size; k++) {
			if newworld[i][k] == undefined {
				newworld[i][k] = instance_create_layer(i, k, "Instances", oTile)
				
				closest = closestCenter(i-expansions, k-expansions)
				if closest == sTile and irandom_range(0, 50)==0 closest = sTileFertile
				if closest == sTileSand and irandom_range(0, 40)==0 closest = sTileGems
				// biome
				newworld[i][k].sprite_index = closest
				newworld[i][k].image_index = irandom_range(0, sprite_get_number(closest)) // random sprite
				// river overrid
				if inArray(rivers, [i-expansions,k-expansions]) newworld[i][k].sprite_index = sTileWater
				newworld[i][k].alarm[0] += 4*i+k*4 + 100
				newworld[i][k].image_speed = sprite_get_speed(newworld[i][k].sprite_index)
				// random trees
				if irandom_range(0,7)==0 and newworld[i][k].sprite_index == sTile newworld[i][k].ontop = sTrees
				// random cacti shit
				if irandom_range(0,10)==0 and newworld[i][k].sprite_index == sTileSand newworld[i][k].ontop = sDesertDecorations
			}
		}
	}
	
	array_copy(oWorld.world, 0, newworld, 0, array_length(newworld))
	newworld = noone
	if year%2==0 and firerisk < 10 firerisk+=1
	redrawTiles()
	show_debug_message(array_length(oWorld.world))
}
function increaseSize() {
	newworld = []
	size += 1
	for (var i = 0; i < size; i++) {
		for (var k = 0; k < size; k++) {
			if i < size-1 and k < size-1 newworld[i][k] = world[i][k]
			 // copy old world
			else {
				newworld[i][k] = instance_create_layer(i, k, "Instances", oTile)
				closest = closestCenter(i, k)
				// biome
				newworld[i][k].sprite_index = closest
				if closest == sTileSand {
					newworld[i][k].image_index = irandom_range(0, sprite_get_number(sTileSand))
				}
				// river override
				if inArray(rivers, [i,k]) newworld[i][k].sprite_index = sTileWater
				newworld[i][k].alarm[0] += 4*i+k*4 + 100
				newworld[i][k].image_speed = sprite_get_speed(newworld[i][k].sprite_index)
				// random trees
				if irandom_range(0,7)==0 and newworld[i][k].sprite_index == sTile newworld[i][k].ontop = sTrees
				// random cacti shit
				if irandom_range(0,10)==0 and newworld[i][k].sprite_index == sTileSand newworld[i][k].ontop = sDesertDecorations
			}
		}
	}
	array_copy(oWorld.world, 0, newworld, 0, array_length(newworld))
	newworld = noone
	redrawTiles()
	show_debug_message(array_length(oWorld.world))
}
// initialize world as size 5ish
for (var i=0; i < 5; i++) {
	increaseSizeAll()
}

//  astar
function neighbors(node, goalx, goaly) {
	n = []
	// gets Structural neighbors that are in bounds.
	// returns an array of nodes with x,y,previous node, and h cost
	// check right
	if node.xx+1 < size{
		array_push(n, {xx : node.xx+1,
		yy : node.yy, 
		camefrom : node, 
		cost: manhattanDistance(node.xx+1, node.yy, goalx, goaly)})
	}
	// check down
	if node.yy+1 < size{
		array_push(n, {xx : node.xx,
		yy : node.yy+1, 
		camefrom : node, 
		cost: manhattanDistance(node.xx, node.yy+1, goalx, goaly)})
	}
	// check left
	if node.xx-1 >= 0{
		array_push(n, {xx : node.xx-1,
		yy : node.yy, 
		camefrom : node, 
		cost: manhattanDistance(node.xx-1, node.yy, goalx, goaly)})
	}
	// check up
	if node.yy-1 >= 0{
		array_push(n, {xx : node.xx,
		yy : node.yy-1, 
		camefrom : node, 
		cost: manhattanDistance(node.xx, node.yy-1, goalx, goaly)})
	}

	return n
}
function dfs(x1,y1,x2,y2, structures = false) {
	frontier = []
	explored = []
	frontier[0] = 
		{xx : x1,
		yy : y1, 
		camefrom : noone, 
		cost: manhattanDistance(x1,y1,x2,y2)}
	
	while array_length(frontier) > 0 {
		_minimum = infinity // default max
		current = frontier[0] // find the cheapest node to explore
		index = 0
		for (i = 0; i < array_length(frontier); i++) {
			if frontier[i].cost < _minimum {
				current = frontier[i]
				_minimum = current.cost
				index = i
			}
		}
		
		// if goal, return node!
		if current.xx == x2 and current.yy == y2 return current // goal
		
		// take it out of the frontier, put it in explored
		array_push(explored, current)
		array_delete(frontier, index, 1)
		
		// otherwise, explore the node
		n = neighbors(current, x2, y2)
		for (k=0;k<array_length(n);k++){
			// check x/y vals in structs. dont use struct comparison, costs are different
			samecoords = false
			for (var p = 0; p < array_length(explored); p++) {
				if explored[p].xx == n[k].xx and explored[p].yy == n[k].yy samecoords = true 
			}
			for (var p = 0; p < array_length(frontier); p++) {
				if frontier[p].xx == n[k].xx and frontier[p].yy == n[k].yy samecoords = true 
			}
			if !samecoords {// if not explored and not in frontier
				// check if we're only searching structures or not
				if !structures {
					array_push(frontier, n[k])// add it to the frontier
				}
				else if world[n[k].xx][n[k].yy].ontop == sRoads or
				world[n[k].xx][n[k].yy].ontop == sTownHall or
				world[n[k].xx][n[k].yy].ontop == sTownHallB or
				world[n[k].xx][n[k].yy].ontop == sTownHallFULL or
				world[n[k].xx][n[k].yy].ontop == sEmptyTile array_push(frontier, n[k])// add it to the frontier if attached to roads
			}
		}
		
	}
	// could not find it!
	return -1
}


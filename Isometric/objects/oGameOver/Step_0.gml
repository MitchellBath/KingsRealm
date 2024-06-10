/// @description Insert description here
// You can write your code in this editor


if room == Results and mouse_check_button_pressed(mb_left) {
	room_goto(Title)
	showing = false
	exit
}

//if populationscore < 20 sprite_index = sHouseFire
//if populationscore > 20 and populationscore < 40 sprite_index = sFarm_Variant00
//if populationscore > 40 and populationscore < 60 sprite_index = sMillVariant00
//if populationscore > 60 and populationscore < 80 sprite_index = sHouseVariants
//if populationscore > 80 sprite_index = sTownHallFULL

if room == Results and !showing {
	// initialize showing
	pthousandsplace = instance_create_layer(474, 624, "GUI", oRollingMeter)
	phundredsplace = instance_create_layer(516, 624, "GUI", oRollingMeter)
	ptensplace = instance_create_layer(558, 624, "GUI", oRollingMeter)
	ponesplace = instance_create_layer(600, 624, "GUI", oRollingMeter)

	ponesplace.image_xscale = 6
	ptensplace.image_xscale = 6
	phundredsplace.image_xscale = 6
	pthousandsplace.image_xscale = 6

	ponesplace.image_yscale = 6
	ptensplace.image_yscale = 6
	phundredsplace.image_yscale = 6
	pthousandsplace.image_yscale = 6
	
	
	ythousandsplace = instance_create_layer(474, 912, "GUI", oRollingMeter)
	yhundredsplace = instance_create_layer(516, 912, "GUI", oRollingMeter)
	ytensplace = instance_create_layer(558, 912, "GUI", oRollingMeter)
	yonesplace = instance_create_layer(600, 912, "GUI", oRollingMeter)

	yonesplace.image_xscale = 6
	ytensplace.image_xscale = 6
	yhundredsplace.image_xscale = 6
	ythousandsplace.image_xscale = 6

	yonesplace.image_yscale = 6
	ytensplace.image_yscale = 6
	yhundredsplace.image_yscale = 6
	ythousandsplace.image_yscale = 6
	
	showing = true
}
if showing and room == Results{
	// population
	var temp = populationscore
	if temp >= 10000 temp = 9999
	pthousandsplace.desirednumber = temp div 1000
	temp -= (temp div 1000) * 1000
	phundredsplace.desirednumber = temp div 100
	temp -= (temp div 100) * 100
	ptensplace.desirednumber = temp div 10
	temp -= (temp div 10) * 10
	ponesplace.desirednumber = temp div 1

	//year
	var temp = yearscore
	if temp >= 10000 temp = 9999
	ythousandsplace.desirednumber = temp div 1000
	temp -= (temp div 1000) * 1000
	yhundredsplace.desirednumber = temp div 100
	temp -= (temp div 100) * 100
	ytensplace.desirednumber = temp div 10
	temp -= (temp div 10) * 10
	yonesplace.desirednumber = temp div 1
}
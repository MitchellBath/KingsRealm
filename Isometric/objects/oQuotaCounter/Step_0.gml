/// @description Insert description here
// You can write your code in this editor

// population
if !instance_exists(oWorld) exit
var temp = oWorld.quota
if temp >= 10000 temp = 9999
pthousandsplace.desirednumber = temp div 1000
temp -= (temp div 1000) * 1000
phundredsplace.desirednumber = temp div 100
temp -= (temp div 100) * 100
ptensplace.desirednumber = temp div 10
temp -= (temp div 10) * 10
ponesplace.desirednumber = temp div 1

//deadline
if !instance_exists(oWorld) exit
var temp = oWorld.deadline
if temp >= 10000 temp = 9999
dthousandsplace.desirednumber = temp div 1000
temp -= (temp div 1000) * 1000
dhundredsplace.desirednumber = temp div 100
temp -= (temp div 100) * 100
dtensplace.desirednumber = temp div 10
temp -= (temp div 10) * 10
donesplace.desirednumber = temp div 1

if position_meeting(mouse_x, mouse_y, self) {
var textbox = instance_create_layer(mouse_x - 500, mouse_y, "GUI", oTextbox)
	textbox.text = "Population quota and year deadline!"
	textbox.alarm[0] = 2	
}
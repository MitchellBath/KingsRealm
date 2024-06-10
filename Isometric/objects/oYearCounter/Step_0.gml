/// @description Insert description here
// You can write your code in this editor

if !instance_exists(oWorld) exit
var temp = oWorld.year
if temp >= 10000 temp = 9999
thousandsplace.desirednumber = temp div 1000
temp -= (temp div 1000) * 1000
hundredsplace.desirednumber = temp div 100
temp -= (temp div 100) * 100
tensplace.desirednumber = temp div 10
temp -= (temp div 10) * 10
onesplace.desirednumber = temp div 1
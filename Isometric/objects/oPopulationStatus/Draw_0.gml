/// @description Insert description here
// You can write your code in this editor


draw_self()

// food warning
if oWorld.population == oWorld.food and current_second%2==0 draw_sprite_ext(sCornAlert, -1, x + sprite_width - 120, y - sprite_height/2 + 10, image_xscale, image_yscale, 0, c_white, 1)
/// @description Insert description here
// You can write your code in this editor

//draw_rectangle_color(x - 5, y - 5, x+boxwidth+5, y+boxheight+5, c_purple, c_purple, c_purple, c_purple, false)
//draw_rectangle_color(x,y, x+boxwidth, y+ boxheight, c_black,c_black,c_black,c_black, false)
draw_sprite_stretched(sTextBox, -1, x, y, boxwidth, boxheight)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_text_ext(x + 8, y+8, text, font_get_size(fontPixel)*1.5, -1)
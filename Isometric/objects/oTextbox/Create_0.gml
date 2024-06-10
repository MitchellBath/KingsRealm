/// @description Insert description here
// You can write your code in this editor


text = ""
alarm[0] = room_speed

text_length = string_length(text)
text_width = string_width_ext(text, font_get_size(fontPixel)*1.5, 1080)
text_height = string_height_ext(text, font_get_size(fontPixel)*1.5, 1920)

boxwidth = text_width + 16
boxheight = text_height + 16
depth = -9000
/// @description Insert description here
// You can write your code in this editor

text_length = string_length(text)
text_width = string_width_ext(text, font_get_size(fontPixel)*1.5, -1)
text_height = string_height_ext(text, font_get_size(fontPixel)*1.5, -1)

boxwidth = text_width + 16
boxheight = text_height + 16
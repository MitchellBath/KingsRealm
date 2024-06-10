/// @description Insert description here
// You can write your code in this editor

if mouse_check_button_pressed(mb_left) {
	if toggle {
		toggle = false
		audio_stop_all()
		image_index = 1
	}
	else {
		toggle = true
		audio_stop_all()
		var audiotheme = audio_play_sound(theme4, 10, true)
		audio_sound_gain(audiotheme, 0.2, 0)
		image_index = 0
	}
}
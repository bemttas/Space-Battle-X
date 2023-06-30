extends Label

var fade_duration = 3.0
var current_time = 0.0
var fade_state = 0
var animation_complete = false

func _process(delta):
	if Globals.lifes <= 0:
		Globals.pausable = false
		visible = true
		current_time += delta

		if fade_state == 0:
			# Fade in
			if current_time >= fade_duration:
				current_time = 0.0
				fade_state = 1
			else:
				modulate.a = current_time / fade_duration

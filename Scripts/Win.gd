extends Label

var fade_duration = 3.0
var current_time = 0.0
var fade_state = 0
var animation_complete = false

func _process(delta):
	if Globals.boss1_died == true or Globals.boss2_died == true:
		visible = true
		current_time += delta

		if fade_state == 0:
			# Fade in
			if current_time >= fade_duration:
				current_time = 0.0
				fade_state = 1
			else:
				modulate.a = current_time / fade_duration

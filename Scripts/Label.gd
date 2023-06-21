extends Label

var fade_duration = 2.0
var current_time = 0.0
var fade_state = 0
var animation_complete = false

func _process(delta):
	if get_node("../../KinematicBody2D").position.x > 3992:
		visible = true
		current_time += delta

		if fade_state == 0:
			# Fade in
			if current_time >= fade_duration:
				current_time = 0.0
				fade_state = 1
			else:
				modulate.a = current_time / fade_duration
		elif fade_state == 1:
			# Fade out
			if current_time >= fade_duration:
				animation_complete = true
			else:
				modulate.a = 1.0 - current_time / fade_duration

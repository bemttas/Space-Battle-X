extends Camera2D

var shake_duration = 0.2  # Duração do tremor em segundos
var shake_amplitude = 2  # Amplitude máxima do tremor em pixels
var shake_timer = 0.0
var original_position = Vector2()

func _ready():
	original_position = position

func shake():
	var shake_duration = 0.5  # Duração do tremor em segundos
	var shake_amplitude = 10 # Amplitude máxima do tremor em pixels
	original_position = position
	shake_timer = shake_duration
	
func shakehit():        
	shake_duration = 0.2 # Duração do tremor em segundos
	shake_amplitude = 2  # Amplitude máxima do tremor em pixels
	original_position = position
	shake_timer = shake_duration

func _process(delta):
	if get_node("../../KinematicBody2D").position.x > 3992:
		zoom.x = 0.5
		zoom.y = 0.5
		limit_bottom = 10
	if shake_timer > 0:
		shake_timer -= delta
		if shake_timer <= 0:
			position = original_position
		else:
			var offset = Vector2(rand_range(-shake_amplitude, shake_amplitude), rand_range(-shake_amplitude, shake_amplitude))
			position = original_position + offset

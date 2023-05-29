extends Camera2D

var shake_duration = 0.5  # Duração do tremor em segundos
var shake_amplitude = 10  # Amplitude máxima do tremor em pixels
var shake_timer = 0.0
var original_position = Vector2()

func _ready():
	original_position = position

func shake():
	original_position = position
	shake_timer = shake_duration

func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta
		if shake_timer <= 0:
			position = original_position
		else:
			var offset = Vector2(rand_range(-shake_amplitude, shake_amplitude), rand_range(-shake_amplitude, shake_amplitude))
			position = original_position + offset

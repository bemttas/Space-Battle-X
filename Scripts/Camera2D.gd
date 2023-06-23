extends Camera2D

var shake_duration = 0.2  # Duração do tremor em segundos
var shake_amplitude = 2  # Amplitude máxima do tremor em pixels
var shake_timer = 0.0
var original_position = Vector2()
var targetZoom = Vector2(0.5, 0.5)
var zoomDuration = 20.0
var currentZoom = Vector2(0.33, 0.33)
var zoomTimer = 0.0
var isZoomingOut = false

var originalzoom = Vector2(0.33, 0.33)

func _ready():
	original_position = position

func shake():
	var shake_duration = 0.5  # Duração do tremor em segundos
	var shake_amplitude = 10 # Amplitude máxima do tremor em pixels
	original_position = position
	shake_timer = shake_duration
	
func shakehigh():
	var shake_duration = 1.0  # Duração do tremor em segundos
	var shake_amplitude = 20 # Amplitude máxima do tremor em pixels
	original_position = position
	shake_timer = shake_duration
	
func shakehit():        
	shake_duration = 0.2 # Duração do tremor em segundos
	shake_amplitude = 2  # Amplitude máxima do tremor em pixels
	original_position = position
	shake_timer = shake_duration

func _process(delta):
	if get_node("../../KinematicBody2D").position.x > 3992:
		if not isZoomingOut:
			isZoomingOut = true
			zoomTimer = 0.0
			currentZoom = originalzoom
		else:
			if zoomTimer < zoomDuration:
				zoomTimer += delta
				var t = zoomTimer / zoomDuration
				currentZoom = currentZoom.linear_interpolate(targetZoom, t)
				zoom = currentZoom
		limit_left = 3786
	else:
		isZoomingOut = false
		limit_left = -482
		zoom = originalzoom
		
		
	if shake_timer > 0:
		shake_timer -= delta
		if shake_timer <= 0:
			position = original_position
		else:
			var offset = Vector2(rand_range(-shake_amplitude, shake_amplitude), rand_range(-shake_amplitude, shake_amplitude))
			position = original_position + offset

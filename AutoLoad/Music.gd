extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play():
	$Audio.play()

func stop():
	$Audio.stop()

func winplay():
	$WIN.play()
	
func winstop():
	$WIN.stop()
	
func bossplay():
	$BOSS.play()
	
func bossstop():
	$BOSS.stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

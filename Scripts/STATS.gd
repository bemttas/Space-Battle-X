extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$num_deaths.text = str(Globals.died_count)
	$num_shots.text = str(Globals.fire_count)
	$num_enemies.text = str(Globals.enemies_count)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

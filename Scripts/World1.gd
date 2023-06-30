extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.boss1_died = false
	Globals.boss2_died = false
	Music.stop()
	Globals.lifes = 3
	Globals.pausable = true

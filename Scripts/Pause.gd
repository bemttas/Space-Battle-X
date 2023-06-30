extends Node

func _ready():
	$ColorRect.visible = false


func _process(_delta):
	if Globals.pausable:
		if Input.is_action_just_pressed("pause"):
			if get_tree().paused == false:
				get_tree().paused = true
				$ColorRect.visible = true
			else:
				get_tree().paused = false
				$ColorRect.visible = false

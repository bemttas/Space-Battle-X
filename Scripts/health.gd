extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if "KinematicBody2D" in body.name:
		get_node("../../KinematicBody2D").HP += 40
		get_node("../../KinematicBody2D/health").play()
		if get_node("../../KinematicBody2D").HP > 100:
			get_node("../../KinematicBody2D").HP = 100
		queue_free()
	pass # Replace with function body.

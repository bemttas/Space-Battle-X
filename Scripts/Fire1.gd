extends RigidBody2D


var vel = Vector2()
var direction = 1


func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir


func _physics_process(delta):
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.play("default")


func _on_Area2D_body_entered(body):
	if "KinematicBody2D" in body.name:
		body.hit(10)
		queue_free()
		
	elif "TileMap" in body.name:
		queue_free()
		
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.

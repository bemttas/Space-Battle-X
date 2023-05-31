extends RigidBody2D


var vel = Vector2()
var direction = 1


func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir


func _physics_process(delta):
	$AnimatedSprite.play("default")

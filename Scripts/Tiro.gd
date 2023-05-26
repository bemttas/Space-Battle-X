extends Area2D


const SPEED = 350
var vel = Vector2()
var direction = 1


func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true



func _physics_process(delta):
	vel.x = SPEED * delta * direction
	translate(vel)
	$AnimatedSprite.play("tiro")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Tiro_body_entered(body):
	if "Slime" in body.name:
		body.hit()
	if "Inimigo" in body.name:
		body.hit()
	queue_free()
pass # Replace with function body.

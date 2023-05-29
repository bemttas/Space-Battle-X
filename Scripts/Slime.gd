extends KinematicBody2D


const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var is_dead = false

var HP = 5

var direction = 1

func _ready():
	pass 

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Area2D/CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	
func hit():
	$TextureProgress.value -= 20
	HP-=1
	if HP <=0:
		dead()
		
		
		
func _physics_process(delta):
	
	if is_dead == false:
		velocity.x = SPEED * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
			
		$AnimatedSprite.play("default")
		
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
		
		
		
		if $RayCast2D.is_colliding() == false:
			direction *= -1
			$RayCast2D.position.x *= -1
			
			
			


func _on_Area2D_body_entered(body):
	if "KinematicBody2D" in body.name:
		body.hit(10)
	pass # Replace with function body.
	
func _on_Timer_timeout():
	queue_free()

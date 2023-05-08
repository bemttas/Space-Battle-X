extends KinematicBody2D


const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2()


var is_dead = false

const HP = 3

var direction = 1

func _ready():
	pass 

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()


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
		
		if is_on_wall():
			direction = direction * -1
			$RayCast2D.position.x *= -1
			
		if $RayCast2D.is_colliding() == false:
			direction *= -1
			$RayCast2D.position.x *= -1
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "KinematicBody2D" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()


func _on_Timer_timeout():
	queue_free()

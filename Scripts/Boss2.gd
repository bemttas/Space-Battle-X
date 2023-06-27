extends KinematicBody2D


const GRAVITY = 10
const SPEED = 70
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var is_dead = false


onready var player = get_node("../../KinematicBody2D")
onready var fire = preload("res://Scenes/FireB.tscn")

export var fireballSpeed = 300  # Velocidade da bola de fogo
export var fireRate = 2  # Taxa de disparo em segundos

const STEP_DISTANCE = 100
var stepCounter = 4

var fireTimer = 0
var HP = 100
var fireballSpawnPoints = []
var direction = 1

func _ready():
	fireballSpawnPoints.append($FireBall1)
	fireballSpawnPoints.append($FireBall2)
	fireballSpawnPoints.append($FireBall3)
	pass 

func dead():
	Globals.enemies_count += 1
	Music.winplay()
	Music.bossstop()
	$hitt.play()
	get_node("../../KinematicBody2D/Camera2D").shakehigh()
	get_node("../../KinematicBody2D").boss_dead = true
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Area2D/CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	Globals.lv2_enable = true
	$BOSSHUD.visible = false
	Globals.boss2_died = true
	
	
func hit():
	$AnimatedSprite.modulate.a = 0.5
	HP-=1
	if HP <=0:
		dead()
	yield(get_tree().create_timer(0.05), "timeout")
	$AnimatedSprite.modulate.a = 1.0
		
		
func _physics_process(delta):
	if player.position.x > 3992:
		visible = true
		$BOSSHUD.visible = true
		$Area2D/CollisionShape2D.disabled = false
		
		if is_dead == false:
			if stepCounter < STEP_DISTANCE:
				var collision = move_and_collide(velocity * delta)
				
				if is_on_wall():
					direction *= -1  # Inverte a direção se houver colisão com uma parede
				
				
				if position.x > player.position.x:
					player.dead()
					
					
				velocity.x = SPEED * direction
				
				if direction == 1:
					$AnimatedSprite.flip_h = true
				else:
					$AnimatedSprite.flip_h = false
					
				$AnimatedSprite.play("andando")
				
				velocity.y += GRAVITY
				
				velocity = move_and_slide(velocity, FLOOR)
				
				stepCounter += abs(velocity.x) * delta
			else:
				stepCounter = 0
				
			fireTimer += delta

			if fireTimer >= fireRate:
				fireTimer = 0
				shoot_fireball()
	else:
		HP = 100
		visible = false
		direction = -1
		$Area2D/CollisionShape2D.disabled = true
		position = Vector2(3735.0, 73.0)
		$BOSSHUD.visible = false
		
func shoot_fireball():
	for spawnPoint in fireballSpawnPoints:
		var direction = (player.global_position - spawnPoint.global_position).normalized()
		var fireballInstance = fire.instance()

		fireballInstance.global_position = spawnPoint.global_position
		fireballInstance.linear_velocity = direction * fireballSpeed

		get_parent().add_child(fireballInstance)
		yield(get_tree().create_timer(0.5), "timeout")
		

func _on_Area2D_body_entered(body):
	if "KinematicBody2D" in body.name:
		body.hit(100)
	pass # Replace with function body.
	
func _on_Timer_timeout():
	queue_free()

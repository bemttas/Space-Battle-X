extends KinematicBody2D


const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var is_dead = false


onready var player = get_node("../../KinematicBody2D")
onready var fire = preload("res://Scenes/Fire.tscn")

export var fireballSpeed = 300  # Velocidade da bola de fogo
export var fireRate = 2  # Taxa de disparo em segundos

const STEP_DISTANCE = 100
var stepCounter = 4

var fireTimer = 0
var HP = 100
var fireballSpawnPoints = []
var direction = -1

func _ready():
	fireballSpawnPoints.append($FireBall1)
	fireballSpawnPoints.append($FireBall2)
	pass 

func dead():
	$hitt.play()
	get_node("../../KinematicBody2D/Camera2D").shakehigh()
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Area2D/CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	$BOSSHUD.visible = false
	#yield(get_tree().create_timer(1.0), "timeout")
	get_node("../../transition").get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	var save_file = File.new()
	if save_file.file_exists(Globals.save_path):
		Globals.createsave()
		get_tree().change_scene(("res://Scenes/menu_level.tscn"))
	else:
		get_tree().change_scene(("res://Scenes/menu_name.tscn"))
	
	
func hit():
	HP-=1
	if HP <=0:
		dead()
		
		
		
func _physics_process(delta):
	if player.position.x > 3992:
		$BOSSHUD.visible = true

		if is_dead == false:
			if stepCounter < STEP_DISTANCE:
				var collision = move_and_collide(velocity * delta)
				
				if collision:
					direction *= -1  # Inverte a direção se houver colisão com uma parede
				
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
			
func shoot_fireball():
	for spawnPoint in fireballSpawnPoints:
		var direction = (player.global_position - spawnPoint.global_position).normalized()
		var fireballInstance = fire.instance()

		fireballInstance.global_position = spawnPoint.global_position
		fireballInstance.linear_velocity = direction * fireballSpeed

		get_parent().add_child(fireballInstance)

func _on_Area2D_body_entered(body):
	if "KinematicBody2D" in body.name:
		body.hit(40)
	pass # Replace with function body.
	
func _on_Timer_timeout():
	queue_free()

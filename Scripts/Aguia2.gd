extends KinematicBody2D

const GRAVITY = 10
const SPEED = 50
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var is_dead = false

onready var player = get_node("../../KinematicBody2D")
onready var fire = preload("res://Scenes/Fire1.tscn")

export var fireballSpeed = 200  # Velocidade da bola de fogo
export var fireRate = 1  # Taxa de disparo em segundos


var fireTimer = 0
var HP = 5
var spawnPoint
var direction = -1


# Adicione essas variáveis para controlar a troca de direção
var change_direction_timer
var change_direction_interval = 6.0

func _ready():

	spawnPoint = $Fireball1

	change_direction_timer = Timer.new()
	change_direction_timer.wait_time = change_direction_interval
	change_direction_timer.connect("timeout", self, "_change_direction")
	add_child(change_direction_timer)
	change_direction_timer.start()
	pass 

func _change_direction():
	direction *= -1

func dead():
	Globals.enemies_count += 1
	$hit.play()
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Area2D/CollisionShape.call_deferred("set_disabled", true)
	$Timer.start()

func hit():
	$AnimatedSprite.modulate.a = 0.5
	$TextureProgress.value -= 20
	HP-=1
	if HP <=0:
		dead()
	yield(get_tree().create_timer(0.05), "timeout")
	$AnimatedSprite.modulate.a = 1.0

func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction

		if direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false

		$AnimatedSprite.play("default")

		velocity = move_and_slide(velocity, FLOOR)
		fireTimer += delta

		if abs(position.x) - abs(Globals.player_position.x) < 100 and abs(position.x) - abs(Globals.player_position.x) > -100:
			if fireTimer >= fireRate:
				fireTimer = 0
				shoot_fireball()
				
				
func shoot_fireball():
	var direction = (player.global_position - spawnPoint.global_position).normalized()
	var fireballInstance = fire.instance()

	fireballInstance.global_position = spawnPoint.global_position
	fireballInstance.linear_velocity = direction * fireballSpeed

	get_parent().add_child(fireballInstance)


	
func _on_Area2D_body_entered(body):
	if "KinematicBody2D" in body.name:
		body.hit(20)
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.

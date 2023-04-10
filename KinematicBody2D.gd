extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 100
const JUMP_HEIGHT = -400
const DASH_SPEED = 350
const DASH_TIME = 0.3
const MAX_SPEED = 200
const ACC = 50

const tiro = preload("res://Tiro.tscn")

var dash_timer = 0
var motion = Vector2()
var lado = true
var isdash = false
var can_dash_in_air = true

var is_dead = false

func _physics_process(delta):
	
	if is_dead == false:
		
		if not isdash:
			motion.y += GRAVITY
		else:
			motion.y = 0
		
		var vif = false
		
		if position.y >= $Camera2D.limit_bottom:
			dead()
		
		
		if Input.is_action_just_pressed("fire"):
			if motion.y < 0 or motion.y > 0:
				var fire = tiro.instance()
				if sign ($Position2D.position.x) == 1:
					fire.set_fireball_direction(1)
				else:
					fire.set_fireball_direction(-1)
				get_parent().add_child(fire)
				fire.global_position = $Position2D.global_position
		
		
		
		
		
		if Input.is_action_just_pressed("dash") and (can_dash_in_air or is_on_floor()): # adiciona verificação de can_dash_in_air
			dash_timer = DASH_TIME
		if dash_timer > 0:
			isdash = true
			can_dash_in_air = false 
			$Sprite.play("dash")
			if lado == true:
				motion.x = DASH_SPEED
				dash_timer -= delta
				$Sprite.flip_h = false
				
			elif lado == false:
				motion.x = -DASH_SPEED
				dash_timer -= delta
				$Sprite.flip_h = true
		else:
			isdash = false


		
		if isdash == false:
			if Input.is_action_pressed("ui_right"):
				motion.x += ACC
				motion.x = min(motion.x+ACC, MAX_SPEED)
				$Sprite.flip_h = false
				$Sprite.play("andar")
				lado = true
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
				
			elif Input.is_action_pressed("ui_left"):
				motion.x = max(motion.x-ACC, -MAX_SPEED)
				$Sprite.flip_h = true
				$Sprite.play("andar")
				lado = false
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
				

			
			else:
				$Sprite.play("parado")
				vif = true
				motion.x = lerp(motion.x, 0,0.2)
			
			
			if is_on_floor():
				if Input.is_action_just_pressed("ui_up"):
					motion.y = JUMP_HEIGHT
				if vif == true:
					motion.x = lerp(motion.x,0,0.2)
				can_dash_in_air = true # adiciona esta linha para reativar o dash no ar
			else:
				if motion.y < 0:
					$Sprite.play("pulo")
				else:
					$Sprite.play("caindo")
				if vif == true:
					motion.x = lerp(motion.x,0,0.05)
					
			
			
		motion = move_and_slide(motion, UP)
		pass
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Inimigo" in get_slide_collision(i).collider.name:
					dead()
		
func dead():
	is_dead = true
	motion = Vector2(0, 0)
	$Sprite.play("dano")
	$CollisionShape2D.disabled = true
	$Timer.start()
	yield(get_tree().create_timer(1.0), "timeout")
	
	get_tree().change_scene(("res://menu.tscn"))
	pass

func _on_Timer_timeout():
	pass # Replace with function body.

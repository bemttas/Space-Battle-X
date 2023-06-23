extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 100
const JUMP_HEIGHT = -400
const DASH_SPEED = 350
const DASH_TIME = 0.3
const MAX_SPEED = 200
const ACC = 50
var boss_dead = false
var blink_time = 0.3
var blink_timer = 0.0

var invincible = false
var invincibleDuration = 1.0
var invincibleTimer = 0.0

var direction

const tiro = preload("res://Scenes/Tiro.tscn")
var HP = 100.0
var dash_timer = 0
var motion = Vector2()
var lado = true
var isdash = false
var can_dash_in_air = true
var agachado = false
var is_dead = false
var hit = false

onready var checkpoint1 = get_node("../Checkpoint1")
onready var checkpoint2 = get_node("../Checkpoint2")
onready var checkpoint3 = get_node("../Checkpoint3")

func _physics_process(delta):
	Globals.player_position = position
	Globals.respawn_point = checkpoint1.position
	print (Globals.respawn_point)
	
	if position.x > checkpoint2.position.x:
		Globals.respawn_point = checkpoint2.position
		
	if position.x > checkpoint3.position.x:
		Globals.respawn_point = checkpoint3.position


	
	
	
	
	if boss_dead == true:
		yield(get_tree().create_timer(3.0), "timeout")
		get_node("../transition").get_node("ColorRect").get_node("animation").play("in")
		yield(get_tree().create_timer(1.0), "timeout")
		var save_file = File.new()
		if save_file.file_exists(Globals.save_path):
			Globals.createsave()
			get_tree().change_scene(("res://Scenes/menu_level.tscn"))
		else:
			get_tree().change_scene(("res://Scenes/menu_name.tscn"))
	
	
	
	modulate.a = 1.0
	if invincible == true:
		blink_timer += delta
		var blink_mod = fmod(blink_timer, blink_time)
		if blink_mod < blink_time / 2:
			modulate.a = 1.0
		else:
			modulate.a = 0.6
	
	if is_dead == false and hit == false and boss_dead == false:
		
		if not isdash:
			motion.y += GRAVITY
		else:
			motion.y = 0
		
		var vif = false
		
		if position.y >= $Camera2D.limit_bottom + 15:
			dead()
		
		
		if Input.is_action_just_pressed("fire"):
			if motion.y < 0 or motion.y > 0:
				$tiro.play()
				var fire = tiro.instance()
				if sign ($Position2D.position.x) == 1:
					fire.set_fireball_direction(1)
				else:
					fire.set_fireball_direction(-1)
				get_parent().add_child(fire)
				fire.global_position = $Position2D.global_position
				
		
		if Input.is_action_just_pressed("dash") and not agachado and(can_dash_in_air or is_on_floor()): # adiciona verificação de can_dash_in_air
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
			if Input.is_action_pressed("ui_right") and not agachado:
				motion.x += ACC
				direction = 1
				motion.x = min(motion.x+ACC, MAX_SPEED)
				$Sprite.flip_h = false
				$Sprite.play("andar")
				lado = true
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
				
			elif Input.is_action_pressed("ui_left") and not agachado:
				direction = -1
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
				$CollisionShape2D.disabled = false
				$CollisionShapeAgachado.disabled = true
				agachado = false
				$Position2D.position.y = -2
				if Input.is_action_just_pressed("ui_up"):
					motion.y = JUMP_HEIGHT
				
				if Input.is_action_pressed("ui_down"):
					agachado = true
					$CollisionShape2D.disabled = true
					$CollisionShapeAgachado.disabled = false
					$Sprite.play("agachado")
					$Position2D.position.y = 9
					
				if vif == true:
					motion.x = lerp(motion.x,0,0.2)
				can_dash_in_air = true
				
			else:
				if motion.y < 0:
					$Sprite.play("pulo")
				else:
					$Sprite.play("caindo")
				if vif == true:
					motion.x = lerp(motion.x,0,0.05)
			
		motion = move_and_slide(motion, UP)
		pass
		
func hit(Damage: int):
	if not invincible:
		$hit.play()
		get_node("Camera2D").shakehit()
		hit = true
		HP = HP-Damage
		motion.y = 0
		$Sprite.play("dano")
		yield(get_tree().create_timer(0.3), "timeout")
		hit = false
		if HP <= 0:
			dead()
		else:
			invincible = true
			invincibleTimer = invincibleDuration
			collision_layer=2
			collision_mask=2
			yield(get_tree().create_timer(1.0), "timeout")
			collision_layer=1
			collision_layer=1
			invincible = false
	
func dead():
	is_dead = true
	motion = Vector2(0, 0)
	$Sprite.play("morte")
	$CollisionShape2D.disabled = true
	$Timer.start()
	Globals.lifes -= 1
	yield(get_tree().create_timer(0.5), "timeout")
	if Globals.lifes > 0: 
		get_node("../transition").get_node("ColorRect").get_node("animation").play("in")
		yield(get_tree().create_timer(1.0), "timeout")
		HP = 100
		get_node("../transition").get_node("ColorRect").get_node("animation").play("out")
		is_dead = false
		$CollisionShape2D.disabled = false
		direction = 1
		position = Globals.respawn_point
		yield(get_tree().create_timer(1.0), "timeout")
	else:
		yield(get_tree().create_timer(4.0), "timeout")
		get_node("../transition").get_node("ColorRect").get_node("animation").play("in")
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene(("res://Scenes/menu.tscn"))


func onInvincibleTimerTimeout():
	invincible = false
	
func _on_Timer_timeout():
	pass


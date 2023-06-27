extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$LineEdit.grab_focus()

func _on_Button_mouse_entered():
	pass # Replace with function body.
func _on_Button_mouse_exited():
	pass # Replace with function body.
func _on_Button_pressed():
	if $LineEdit.text == "":
		Globals.nickname = "Anonymous"
	else:
		Globals.nickname = $LineEdit.text
	Globals.lv2_enable = true
	Globals.createsave()
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene(("res://Scenes/menu_level.tscn"))

func _process(delta):
	Music.bossstop()
	$ParallaxBackground.scroll_offset.y -= 100 * delta


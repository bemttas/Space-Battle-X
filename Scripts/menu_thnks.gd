extends Control

# Init function
func _ready():
	$HBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene(("res://Scenes/menu.tscn"))
func _on_Button_mouse_entered():
	$HBoxContainer/Button.grab_focus()
	

# Main function
func _process(delta):
	Music.bossstop()
	$ParallaxBackground.scroll_offset.x += 100 * delta
	$ParallaxBackground.scroll_offset.y -= 100 * delta * 0.5


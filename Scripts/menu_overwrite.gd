extends Control

# Init function
func _ready():
	$HBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene(("res://Scenes/menu.tscn"))
func _on_Button_mouse_entered():
	$HBoxContainer/Button2.release_focus()
	$HBoxContainer/Button2.set_focus_mode(0)
	$HBoxContainer/Button.grab_focus()
func _on_Button_mouse_exited():
	$HBoxContainer/Button2.set_focus_mode(2)


func _on_Button2_pressed():
	
	var dir = Directory.new()
	dir.remove(Globals.save_path)
	Globals.reset_var()
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	Globals.lv1_in = true
	Globals.lv2_in = false
	get_tree().change_scene(("res://Scenes/World.tscn"))
func _on_Button2_mouse_entered():
	$HBoxContainer/Button.release_focus()
	$HBoxContainer/Button.set_focus_mode(0)
	$HBoxContainer/Button2.grab_focus()
func _on_Button2_mouse_exited():
	$HBoxContainer/Button.set_focus_mode(2)


# Main function
func _process(delta):
	Music.bossstop()
	$ParallaxBackground.scroll_offset.x += 100 * delta
	$ParallaxBackground.scroll_offset.y -= 100 * delta * 0.5


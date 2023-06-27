extends Control

# Save variables
var exist_save = false

# Init function
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var save_file = File.new()
	if save_file.file_exists(Globals.save_path):
		exist_save = true
		$VBoxContainer/Button.set("custom_colors/font_color_focus", Color(1,1,0,1))
		$VBoxContainer/Button.set("custom_colors/font_color_hover", Color(1,1,0,1))
		$VBoxContainer/Button.set("custom_colors/font_color", Color(1,1,1,1))
		$VBoxContainer/Button.grab_focus() 
	else:
		$VBoxContainer/Button.set("custom_colors/font_color_focus", Color(0.29,0.29,0,1))
		$VBoxContainer/Button.set("custom_colors/font_color_hover", Color(0.29,0.29,0,1))
		$VBoxContainer/Button.set("custom_colors/font_color", Color(0.29,0.29,0.29,1))
		$VBoxContainer/Button2.grab_focus()
	print(Globals.save_path)

func _on_Button_mouse_entered():
	$VBoxContainer/Button2.release_focus()
	$VBoxContainer/Button2.set_focus_mode(0)
	$VBoxContainer/Button3.release_focus()
	$VBoxContainer/Button3.set_focus_mode(0)
	$VBoxContainer/Button.grab_focus()
func _on_Button_mouse_exited():
	$VBoxContainer/Button2.set_focus_mode(2)
	$VBoxContainer/Button3.set_focus_mode(2)
func _on_Button_pressed():
	if exist_save:
		Globals.loadsave()
		$transition.get_node("ColorRect").get_node("animation").play("in")
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene(("res://Scenes/menu_level.tscn"))

func _on_Button2_mouse_entered():
	$VBoxContainer/Button.release_focus()
	$VBoxContainer/Button.set_focus_mode(0)
	$VBoxContainer/Button3.release_focus()
	$VBoxContainer/Button3.set_focus_mode(0)
	$VBoxContainer/Button2.grab_focus()
func _on_Button2_mouse_exited():
	$VBoxContainer/Button.set_focus_mode(2)
	$VBoxContainer/Button3.set_focus_mode(2)
func _on_Button2_pressed():
	if exist_save:
		$transition.get_node("ColorRect").get_node("animation").play("in")
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene(("res://Scenes/menu_overwrite.tscn"))
	else:
		$transition.get_node("ColorRect").get_node("animation").play("in")
		yield(get_tree().create_timer(1.0), "timeout")
		Globals.lv1_in = true
		Globals.lv2_in = false
		get_tree().change_scene(("res://Scenes/World.tscn"))

func _on_Button3_mouse_entered():
	$VBoxContainer/Button2.release_focus()
	$VBoxContainer/Button2.set_focus_mode(0)
	$VBoxContainer/Button.release_focus()
	$VBoxContainer/Button.set_focus_mode(0)
	$VBoxContainer/Button3.grab_focus()
func _on_Button3_mouse_exited():
	$VBoxContainer/Button2.set_focus_mode(2)
	$VBoxContainer/Button.set_focus_mode(2)
func _on_Button3_pressed():
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	if exist_save:
		var dir = Directory.new()
		dir.remove(Globals.save_path)
	get_tree().quit()

func _process(delta):
	Music.bossstop()
	$ParallaxBackground.scroll_offset.x -= 100 * delta
	$ParallaxBackground.scroll_offset.y -= 100 * delta * 0.5

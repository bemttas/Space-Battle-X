extends Control

# Init function
func _ready():
	$TextEdit.text = Globals.nickname
	$HBoxContainer/Button.grab_focus()
	if Globals.lv2_enable:
		$HBoxContainer/Button2.set("custom_colors/font_color_focus", Color(1,1,0,1))
		$HBoxContainer/Button2.set("custom_colors/font_color_hover", Color(1,1,0,1))
		$HBoxContainer/Button2.set("custom_colors/font_color", Color(1,1,1,1))
	else:
		$HBoxContainer/Button2.set("custom_colors/font_color_focus", Color(0.29,0.29,0,1))
		$HBoxContainer/Button2.set("custom_colors/font_color_hover", Color(0.29,0.29,0,1))
		$HBoxContainer/Button2.set("custom_colors/font_color", Color(0.29,0.29,0.29,1))

# Statistics button signal
func _on_Button5_mouse_entered():
	$HBoxContainer2/Button4.release_focus()
	$HBoxContainer2/Button4.set_focus_mode(0)
	$HBoxContainer/Button.release_focus()
	$HBoxContainer/Button.set_focus_mode(0)
	$HBoxContainer/Button2.release_focus()
	$HBoxContainer/Button2.set_focus_mode(0)
	$HBoxContainer/Button3.release_focus()
	$HBoxContainer/Button3.set_focus_mode(0)
	$HBoxContainer2/Button5.grab_focus()
func _on_Button5_mouse_exited():
	$HBoxContainer2/Button4.set_focus_mode(2)
	$HBoxContainer/Button.set_focus_mode(2)
	$HBoxContainer/Button2.set_focus_mode(2)
	$HBoxContainer/Button3.set_focus_mode(2)
func _on_Button5_pressed():
	pass

# Back button signal
func _on_Button4_mouse_entered():
	$HBoxContainer2/Button5.release_focus()
	$HBoxContainer2/Button5.set_focus_mode(0)
	$HBoxContainer/Button.release_focus()
	$HBoxContainer/Button.set_focus_mode(0)
	$HBoxContainer/Button2.release_focus()
	$HBoxContainer/Button2.set_focus_mode(0)
	$HBoxContainer/Button3.release_focus()
	$HBoxContainer/Button3.set_focus_mode(0)
	$HBoxContainer2/Button4.grab_focus()
func _on_Button4_mouse_exited():
	$HBoxContainer2/Button5.set_focus_mode(2)
	$HBoxContainer/Button.set_focus_mode(2)
	$HBoxContainer/Button2.set_focus_mode(2)
	$HBoxContainer/Button3.set_focus_mode(2)
func _on_Button4_pressed():
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene(("res://Scenes/menu.tscn"))

# Level 1 button signal
func _on_Button_mouse_entered():
	$HBoxContainer2/Button4.release_focus()
	$HBoxContainer2/Button4.set_focus_mode(0)
	$HBoxContainer2/Button5.release_focus()
	$HBoxContainer2/Button5.set_focus_mode(0)
	$HBoxContainer/Button2.release_focus()
	$HBoxContainer/Button2.set_focus_mode(0)
	$HBoxContainer/Button3.release_focus()
	$HBoxContainer/Button3.set_focus_mode(0)
	$HBoxContainer/Button.grab_focus()
func _on_Button_mouse_exited():
	$HBoxContainer2/Button4.set_focus_mode(2)
	$HBoxContainer2/Button5.set_focus_mode(2)
	$HBoxContainer/Button2.set_focus_mode(2)
	$HBoxContainer/Button3.set_focus_mode(2)
func _on_Button_pressed():
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	Globals.lv1_in = true
	Globals.lv2_in = false
	get_tree().change_scene(("res://Scenes/World.tscn"))

# Level 2 button signal
func _on_Button2_mouse_entered():
	$HBoxContainer2/Button4.release_focus()
	$HBoxContainer2/Button4.set_focus_mode(0)
	$HBoxContainer2/Button5.release_focus()
	$HBoxContainer2/Button5.set_focus_mode(0)
	$HBoxContainer/Button.release_focus()
	$HBoxContainer/Button.set_focus_mode(0)
	$HBoxContainer/Button2.grab_focus()
func _on_Button2_mouse_exited():
	$HBoxContainer2/Button4.set_focus_mode(2)
	$HBoxContainer2/Button5.set_focus_mode(2)
	$HBoxContainer/Button.set_focus_mode(2)
func _on_Button2_pressed():
	if Globals.lv2_enable:
			$transition.get_node("ColorRect").get_node("animation").play("in")
			yield(get_tree().create_timer(1.0), "timeout")
			Globals.lv1_in = true
			Globals.lv2_in = false
			get_tree().change_scene(("res://Scenes/World1.tscn"))

# Main function
func _process(delta):
	$ParallaxBackground.scroll_offset.x -= 100 * delta * 0.5
	$ParallaxBackground.scroll_offset.y -= 100 * delta


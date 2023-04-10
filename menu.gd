extends Control

func _on_Button_pressed():
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	
	get_tree().change_scene(("res://World.tscn"))
	
	pass # Replace with function body.


func _on_Button3_pressed():
	$transition.get_node("ColorRect").get_node("animation").play("in")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().quit()
	pass # Replace with function body.

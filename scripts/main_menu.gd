extends Control

func _on_button2_pressed() -> void:
	# new game
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _on_button_pressed() -> void:
	#credits

	pass

func _on_Button3_pressed() -> void:
	# options
	get_tree().quit()

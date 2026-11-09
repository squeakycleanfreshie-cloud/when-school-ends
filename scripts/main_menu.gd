extends Control

@onready var main_buttons: VBoxContainer = $VBoxContainer
@onready var options: Panel = $Options



func _on_button2_pressed() -> void:
	# new game
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _ready():
	main_buttons.visible = true
	options.visible = false
	
	

func _on_Button3_pressed() -> void:
	# options
	get_tree().quit()



func _on_button_3_pressed() -> void:
	main_buttons.visible = false
	options.visible = true
	


func _on_back_pressed() -> void:
	main_buttons.visible = true
	options.visible = false


 

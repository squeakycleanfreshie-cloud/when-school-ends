extends Button

func _ready():
	print("exit button ready")

# links the button to the thing usin signals
func _pressed():
	print("exit pressed")
	print(get_tree().change_scene_to_file("res://scenes/main_menu.tscn"))

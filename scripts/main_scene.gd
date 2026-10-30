extends Node2D

@onready var background = %TextureRect
@onready var character = %character_sprite
@onready var dialog_ui = %Dialog_UI
@onready var next_scentence_sound = %NextScentenceSound

var transition_effect: String = "fade"
var dialog_file: String = "res://story/first_scene.json"
var dialog_index: int = 0
var dialog_lines: Array = []
var transitioning: bool = false

func _ready():
	dialog_lines = load_dialog(dialog_file)
	dialog_ui.animation_done.connect(_on_animation_done)
	dialog_ui.choice_selected.connect(_on_choice_selected)
	SceneManager.transition_out_completed.connect(_on_transition_out_completed)
	SceneManager.transition_in_completed.connect(_on_transition_in_completed)
	dialog_index = 0
	process_current_line()

func _input(event):
	if transitioning or dialog_lines.is_empty() or dialog_index >= dialog_lines.size():
		return
	var line = dialog_lines[dialog_index]
	var has_choices = line.has("choices")
	if event.is_action_pressed("next_line") and not has_choices:
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if dialog_index < len(dialog_lines) - 1:
				dialog_index += 1
				next_scentence_sound.play()
				process_current_line()

func process_current_line():
	if dialog_index >= dialog_lines.size() or dialog_index < 0:
		printerr("dialog index out of bounds")
		return

	var line = dialog_lines[dialog_index]

	if line.has("next_scene"):
		dialog_file = "res://story/" + line["next_scene"] + ".json"
		transition_effect = line.get("transition", "fade")
		transitioning = true
		SceneManager.transition_out(transition_effect)
		return

	if line.has("location"):
		var background_file = "res://assets/backgrounds/" + line["location"] + ".jpg"
		background.texture = load(background_file)
		dialog_index += 1
		process_current_line()
		return

	if line.has("goto"):
		dialog_index = get_anchor_postion(line["goto"])
		process_current_line()
		return

	if line.has("anchor"):
		dialog_index += 1
		process_current_line()
		return

	if line.has("show_character"):
		var shown_name = Character.get_enum_from_string(line["show_character"])
		character.change_character(shown_name, false, line.get("expression", ""))
	elif line.has("speaker"):
		var speaker_char = Character.get_enum_from_string(line["speaker"])
		character.change_character(speaker_char, true, line.get("expression", ""))

	if line.has("choices"):
		dialog_ui.display_choices(line["choices"])
	elif line.has("text"):
		var speaker_name = Character.get_enum_from_string(line.get("speaker", ""))
		dialog_ui.change_line(speaker_name, line["text"])
	else:
		if dialog_index < len(dialog_lines) - 1:
			dialog_index += 1
			process_current_line()
		return

func get_anchor_postion(anchor: String) -> int:
	for i in range(dialog_lines.size()):
		if dialog_lines[i].has("anchor") and dialog_lines[i]["anchor"] == anchor:
			return i
	printerr("could not find anchor " + anchor)
	return dialog_index + 1

func load_dialog(file_path) -> Array:
	if not FileAccess.file_exists(file_path):
		printerr("Error: File don't even exist bro ", file_path)
		return []

	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Error: Failed to Open File ", file_path)
		return []

	var content = file.get_as_text()
	var json_content = JSON.parse_string(content)

	if json_content == null or not json_content is Array:
		printerr("Error: Failed to parse JSON ", file_path)
		return []

	return json_content

func _on_animation_done():
	character.play_idle_animation()

func _on_choice_selected(anchor: String):
	dialog_index = get_anchor_postion(anchor)
	process_current_line()
	next_scentence_sound.play()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_transition_out_completed():
	dialog_lines = load_dialog(dialog_file)
	dialog_index = 0
	process_current_line()
	SceneManager.transition_in(transition_effect)

func _on_transition_in_completed():
	transitioning = false

extends Node2D

@onready var character = %character_sprite
@onready var dialog_ui = %Dialog_UI
@onready var next_scentence_sound = %NextScentenceSound

var dialog_index : int = 0

var dialog_lines : Array = []

func _ready():
	
	dialog_lines = load_dialog("res://story/story.json")
	dialog_ui.animation_done.connect(_on_animation_done)
	# Process first line of dialog.
	dialog_index = 0
	process_current_line()

func _input(event):
	if event.is_action_pressed("next_line"):
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if dialog_index < len(dialog_lines) - 1:
				dialog_index += 1
				next_scentence_sound.play()
				process_current_line()

func parse_line(line: String):
	var line_info = line.split(":")
	assert(len(line_info) >= 2)
	return {
		"speaker_name": line_info[0],
		"dialog_line": line_info[1]
	}

func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info = parse_line(line)
	var character_name = Character.get_enum_from_string(line_info["speaker_name"])
	dialog_ui.change_line(character_name, line_info["dialog_line"])
	character.change_character(character_name)
	
func load_dialog(file_path):
	if not FileAccess.file_exists(file_path):
		printerr("Error: File don't even exist bro", file_path)
		return null 
		
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Error: Failed to Open File", file_path)
		return null
	
	var content = file.get_as_text()

	
	var json_content = JSON.parse_string(content)
 
	if json_content == null:
		printerr("Error: Failed to parse JSON", file_path)
		return null
	
	
	return json_content 
 
func _on_animation_done():
	character.play_idle_animation()

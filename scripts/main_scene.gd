extends Node2D

@onready var character = %character_sprite
@onready var dialog_ui = %Dialog_UI

var dialog_index : int = 0

const dialog_lines : Array[String] = [
	"Oakley: Come on guys, lets do this!",
	"Finn: I'm only coming if everyone else comes.",
	"Hugo: I'm in!",
	"Mia: Fine. I guess I will come.",
	"Oakley: Yes! What about you Chloe?",
	"Chloe: I'm sorry guys, I have to study.",
	"Chloe: I have lots of stuff on, and hanging out is one of the lower prorities on that list.",
	"Mia: Are you sure? Please come.",
	"Chloe: I'm sorry. I'm just really stressed at the moment",
	"Oakley: But if you come, that could be an opportunity to de-stress.",
	"Chloe: I guess...",
	"Chloe: Fine, I'll come- but just this once."
]

func _ready():
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
	dialog_ui.change_line(line_info["speaker_name"], line_info["dialog_line"])
	character.change_character(line_info["speaker_name"])
 
func _on_animation_done():
	character.play_idle_animation()

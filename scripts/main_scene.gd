extends Node2D

@onready var character = %character
@onready var dialog_ui = %Dialog_UI

var dialog_index : int = 0

const dialog_lines : Array[String] = [
	"Oakley: Come on guys, lets do this!",
	"Finn: I'm only coming if everyone else comes.",
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
	dialog_index = 0
	process_line(parse_line(dialog_lines[dialog_index]))
	
func _input(event):
	pass
	
 	
func parse_line(line: String):
	var line_info = line.split(":")
	assert(len(line_info) >= 2)
	return {
		"speaker_name": line_info[0],
		"dialog_line": line_info[1]
	}
	
func process_line(line_info: Dictionary):
	dialog_ui.speaker_name.text = line_info["speaker_name"]
	dialog_ui.dialog_line.text = line_info["dialog_line"]

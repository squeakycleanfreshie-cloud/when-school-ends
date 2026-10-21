extends Control

signal animation_done

const ANIMATION_SPEED : int = 30
var animate_text : bool = false
var current_visible_characters : int = 0

@onready var dialog_line = %Dialog_Line
@onready var speaker_name = %Speaker_Name

func _process(delta):
	if animate_text:
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0/dialog_line.text.length()) * (ANIMATION_SPEED * delta)
			current_visible_characters = dialog_line.visible_characters
		else:
			animate_text = false
			animation_done.emit()
	pass

func change_line(speaker: String, line: String):
	speaker_name.text = speaker
	current_visible_characters = 0
	dialog_line.text = line
	dialog_line.visible_characters = 0
	animate_text = true 
	
func skip_text_animation():
	dialog_line.visible_ratio = 1

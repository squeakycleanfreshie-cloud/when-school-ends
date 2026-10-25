extends Control

signal animation_done
signal choice_selected

const ChoiceButtonScene = preload("res://scenes/player_choice.tscn")

@onready var dialog_line = %Dialog_Line
@onready var speaker_name = %Speaker_Name
@onready var choice_list = %ChoiceList
@onready var text_blip_sound = %TextBlipSound
@onready var text_blip_timer = %TextBlipTimer
@onready var scentence_pause_timer = %ScentencePauseTimer

const ANIMATION_SPEED : int = 30
const NO_SOUND_CHARS : Array = [".","!","?",","]
var animate_text : bool = false
var current_visible_characters : int = 0
var current_character_details : Dictionary

func _ready():
	choice_list.hide()
	text_blip_timer.timeout.connect(_on_text_blip_timeout)
	scentence_pause_timer.timeout.connect(_on_scentence_pause_timeout)

func _process(delta):
	if not animate_text or not scentence_pause_timer.is_stopped():
		return
	var total : int = dialog_line.text.length()
	if total == 0 or dialog_line.visible_ratio >= 1.0:
		_finish_animation()
		return
	dialog_line.visible_ratio += (ANIMATION_SPEED * delta) / total
	var new_count : int = dialog_line.visible_characters
	if new_count == -1:
		new_count = total
	for i in range(current_visible_characters, new_count):
		var ch : String = dialog_line.text[i]
		if NO_SOUND_CHARS.has(ch) and i + 1 < total and dialog_line.text[i + 1] == " ":
			dialog_line.visible_characters = i + 1
			current_visible_characters = i + 1
			text_blip_timer.stop()
			scentence_pause_timer.start()
			return
	current_visible_characters = new_count

func _finish_animation():
	animate_text = false
	text_blip_timer.stop()
	animation_done.emit()

func change_line(character_name: Character.Name, line: String):
	scentence_pause_timer.stop()
	current_character_details = Character.CHARACTER_DETAILS[character_name]
	speaker_name.text = current_character_details["name"]
	current_visible_characters = 0
	dialog_line.text = line
	dialog_line.visible_characters = 0
	animate_text = true
	text_blip_timer.start()
	
func display_choices(choices: Array):
	
	for child in choice_list.get_children():
		child.queue_free()

	for choice in choices:
		var choice_button = ChoiceButtonScene.instantiate()
		choice_button.text = choice["text"]
		choice_button.pressed.connect(_on_choice_button_pressed.bind(choice["goto"]))
		choice_list.add_child(choice_button)
	choice_list.show()

func skip_text_animation():
	scentence_pause_timer.stop()
	dialog_line.visible_ratio = 1

func _on_text_blip_timeout():
	text_blip_sound.play_sound(current_character_details)
	


func _on_scentence_pause_timeout():
	text_blip_timer.start()
	
func _on_choice_button_pressed(anchor: String):
	choice_selected.emit(anchor)
	choice_list.hide()

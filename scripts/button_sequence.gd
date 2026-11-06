extends CanvasLayer

signal finished(success: bool)

@onready var button_box: HBoxContainer = %buttonBox
@onready var timelabel: Label = %timelabel
@onready var success_label: Label = %success_label
@onready var timer: Timer = $Timer

var buttonSelection = [
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")},
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")},
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")},
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")},
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")},
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")},
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")},
	{"action": "up", "icon": preload("res://assets/icons/home_icon.png")}
]

var actionSequence: Array = []
var sequence_index := 0
var is_done := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS # keep running while tree is paused
	get_tree().paused = true
	success_label.hide()
	_set_random_sequence()
	timer.start()

func _process(_delta: float) -> void:
	if not is_done:
		timelabel.text = "%.1f" % timer.time_left

func _set_random_sequence() -> void:
	actionSequence.clear()
	for node in button_box.get_children():
		var randomPick = buttonSelection.pick_random()
		node.texture = randomPick.icon
		actionSequence.append(randomPick.action)

func _unhandled_input(event: InputEvent) -> void:
	if is_done or sequence_index >= actionSequence.size():
		return

	for action in ["up"]: 
		if event.is_action_pressed(action):
			if action == actionSequence[sequence_index]:
				button_box.get_child(sequence_index).modulate = Color(1, 1, 1, 0.3)
				sequence_index += 1
				if sequence_index >= actionSequence.size():
					_finish(true)
			else:
				_finish(false)
			return

func _on_timer_timeout() -> void:
	_finish(false)

func _finish(success: bool) -> void:
	if is_done:
		return
	is_done = true
	timer.stop()
	_update_success_label(success)
	get_tree().paused = false
	finished.emit(success)

func _update_success_label(success: bool) -> void:
	success_label.show()
	if success:
		success_label.text = "SUCCESS"
		success_label.add_theme_color_override("font_color", Color.GREEN)
	else:
		success_label.text = "FAIL"
		success_label.add_theme_color_override("font_color", Color.RED)

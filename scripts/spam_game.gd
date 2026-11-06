extends CanvasLayer

signal finished(success: bool)

@onready var time_label: Label = %timeLabel
@onready var player_bar: ProgressBar = %playerBar
@onready var rival_bar: ProgressBar = %rivalBar
@onready var result_label: Label = %resultLabel


@export var test_mode := false
@export var time_limit := 6.0
@export var press_gain := 4.0    
@export var decay_per_sec := 10.0  
@export var rival_speed := 0.0    


var progress := 0.0
var rival_progress := 0.0
var time_left := 0.0
var running := false

func _ready() -> void:
	player_bar.max_value = 100.0
	rival_bar.max_value = 100.0
	result_label.hide()
	_refresh()
	if test_mode:
		start()

func start(config: Dictionary = {}) -> void:
	time_limit = config.get("time_limit", time_limit)
	press_gain = config.get("press_gain", press_gain)
	decay_per_sec = config.get("decay_per_sec", decay_per_sec)
	rival_speed = config.get("rival_speed", rival_speed)
	rival_bar.visible = rival_speed > 0.0
	time_left = time_limit
	progress = 0.0
	rival_progress = 0.0
	running = true

func _input(event: InputEvent) -> void:
	if running and event.is_action_pressed("spam"):
		progress += press_gain
		if progress >= 100.0:
			progress = 100.0
			_refresh()
			_finish(true)

func _process(delta: float) -> void:
	if not running:
		return
	time_left -= delta
	progress = maxf(progress - decay_per_sec * delta, 0.0)
	rival_progress += rival_speed * delta
	_refresh()

	if rival_speed > 0.0 and rival_progress >= 100.0:
		_finish(false)
	elif time_left <= 0.0:
		_finish(false)

func _refresh() -> void:
	player_bar.value = progress
	rival_bar.value = rival_progress
	time_label.text = "%.1f" % maxf(time_left, 0.0)

func _finish(success: bool) -> void:
	if not running:
		return
	running = false
	result_label.text = "YOU WIN!" if success else "TOO SLOW!"
	result_label.show()
	await get_tree().create_timer(1.0).timeout
	finished.emit(success)
	queue_free()

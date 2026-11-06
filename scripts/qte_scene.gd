extends Control

signal all_finished(results: Array)

@onready var timer: Timer = $Timer

const QTE = preload("res://scenes/qte.tscn")

@export var qte_size := Vector2(128, 128) 
@export var margin := 20.0

var keyList = [
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "E", "keyCode": KEY_E},
	{"keyString": "G", "keyCode": KEY_G},
	{"keyString": "M", "keyCode": KEY_M},
	{"keyString": "G", "keyCode": KEY_G},
	{"keyString": "E", "keyCode": KEY_E},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "L", "keyCode": KEY_L},
	{"keyString": "W", "keyCode": KEY_W},
	{"keyString": "S", "keyCode": KEY_S}
]

var count := 0
var KeyPressedList: Array = []
var used_positions: Array[Vector2] = []

func _on_timer_timeout() -> void:
	if count >= keyList.size():
		timer.stop()
		return

	var keyNode = QTE.instantiate()
	keyNode.keyCode = keyList[count].keyCode
	keyNode.keyString = keyList[count].keyString
	keyNode.finished.connect(_on_key_finished)
	add_child(keyNode)

	keyNode.set_anchors_preset(Control.PRESET_TOP_LEFT)
	keyNode.size = qte_size
	keyNode.position = _get_spawn_position()
	used_positions.append(keyNode.position)
	count += 1

func _get_spawn_position() -> Vector2:
	var area := size
	if area.x <= 0.0 or area.y <= 0.0:
		area = get_viewport_rect().size

	var max_x := maxf(area.x - qte_size.x - margin, margin + 1.0)
	var max_y := maxf(area.y - qte_size.y - margin, margin + 1.0)

	var pos := Vector2.ZERO
	for i in 30:
		pos = Vector2(randf_range(margin, max_x), randf_range(margin, max_y))
		var overlaps := false
		for p in used_positions:
			if pos.distance_to(p) < qte_size.x:
				overlaps = true
				break
		if not overlaps:
			break
	return pos

func _on_key_finished(success: bool) -> void:
	KeyPressedList.append(success)
	if KeyPressedList.size() == keyList.size():
		all_finished.emit(KeyPressedList)

extends Control

@onready var timer: Timer = $Timer

const QTE = preload("res://scenes/qte.tscn")

var keyList = [
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q},
	{"keyString": "Q", "keyCode": KEY_Q}
	
]

var count = 0
var KeyPressedList = []


func _on_timer_timeout() -> void:
	if count == keyList.size():
		timer.stop()
		return
		
	var keyNode = QTE.instantiate()
	keyNode.finished.connect(_on_key_finished)
	keyNode.keyCode = keyList[count].keyCode
	keyNode.keyString = keyList[count].keyString
	
	add_child(keyNode)
	count += 1

func _on_key_finished(success: bool) -> void:
	KeyPressedList.append(success)

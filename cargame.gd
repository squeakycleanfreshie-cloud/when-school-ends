extends Node

signal finished(success: bool)

var current: Node
var current_path := ""
var data: Dictionary = {}
var hidden_layers: Array = []

func play(path: String, line_data: Dictionary = {}) -> bool:
	print("CarGame.play called: ", path)
	current_path = path
	data = line_data
	if not _spawn():
		return false
	var success = await finished
	return success

func _spawn() -> bool:
	var vn = get_tree().current_scene

	if not ResourceLoader.exists(current_path):
		printerr("Car game scene not found: ", current_path)
		return false

	current = load(current_path).instantiate()
	get_tree().root.add_child(current)
	print("spawned: ", current)

	vn.process_mode = Node.PROCESS_MODE_DISABLED
	if vn is CanvasItem:
		vn.hide()
	hidden_layers.clear()
	for child in vn.get_children():
		if child is CanvasLayer and child.visible:
			child.hide()
			hidden_layers.append(child)
	return true

func restart() -> void:
	print("CarGame.restart, current = ", current, " path = ", current_path)
	if current == null:
		print("current is null, reloading current scene instead")
		get_tree().reload_current_scene()
		return
	var old = current
	current = null
	_swap.call_deferred(old)

func _swap(old: Node) -> void:
	print("swapping game")
	if is_instance_valid(old):
		get_tree().root.remove_child(old)
		old.queue_free()
	current = load(current_path).instantiate()
	get_tree().root.add_child(current)
	print("new game added: ", current)

func finish(success: bool = true) -> void:
	print("CarGame.finish: ", success)
	if current:
		var old = current
		current = null
		get_tree().root.remove_child.call_deferred(old)
		old.queue_free.call_deferred()
	var vn = get_tree().current_scene
	vn.process_mode = Node.PROCESS_MODE_INHERIT
	if vn is CanvasItem:
		vn.show()
	for layer in hidden_layers:
		if is_instance_valid(layer):
			layer.show()
	hidden_layers.clear()
	finished.emit(success)

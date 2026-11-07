extends CanvasLayer
const GAMES := {
	"qte": "res://scenes/qte_scene.tscn",
	"button_sequence": "res://scenes/button_sequence.tscn",
	"spam": "res://scenes/spam_game.tscn",
}

func _ready() -> void:
	layer = 100
	process_mode = Node.PROCESS_MODE_ALWAYS

func play(game: String, config: Dictionary = {}) -> bool:
	if not GAMES.has(game):
		printerr("unknown mingames", game)
		return false
	var node = load(GAMES[game]).instantiate()
	add_child(node)
	if node.has_method("start"):
		node.start(config)
	var success: bool = await node.finished
	if is_instance_valid(node):
		node.queue_free()
	return success
	

extends Node2D

var coins: int = 0
var fuel_style: StyleBoxFlat

func _enter_tree() -> void:
	add_to_group("level_man")

func _ready() -> void:
	fuel_style = StyleBoxFlat.new()
	fuel_style.bg_color = Color.from_hsv(0.3, 0.8, 0.9)
	$CarGameUi/feul/ProgressBar.add_theme_stylebox_override("fill", fuel_style)

	var p = get_tree().get_first_node_in_group("player")
	if p:
		p.fuel_changed.connect(update_feul_ui)
		update_feul_ui(p.fuel)

func add_coins(amount: int) -> void:
	coins += amount
	$CarGameUi/Coin/Label.text = str(coins)

func update_feul_ui(value: float) -> void:
	$CarGameUi/feul/ProgressBar.value = value
	fuel_style.bg_color = Color.from_hsv(lerp(0.0, 0.3, value / 100.0), 0.8, 0.9)

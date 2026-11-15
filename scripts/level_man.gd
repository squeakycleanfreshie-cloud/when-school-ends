extends Node2D

var coins: int = 0
var fuel_style: StyleBoxFlat

func _ready() -> void:
	_setup_fuel_style()

func _setup_fuel_style() -> void:
	if fuel_style:
		return
	fuel_style = StyleBoxFlat.new()
	fuel_style.bg_color = Color.from_hsv(0.3, 0.8, 0.9)
	$CarGameUi/feul/ProgressBar.add_theme_stylebox_override("fill", fuel_style)

func add_coins(amount: int) -> void:
	coins += amount
	$CarGameUi/Coin/Label.text = str(coins)

func update_feul_ui(value: float) -> void:
	_setup_fuel_style()
	$CarGameUi/feul/ProgressBar.value = value
	fuel_style.bg_color = Color.from_hsv(lerp(0.0, 0.3, value / 100.0), 0.8, 0.9)

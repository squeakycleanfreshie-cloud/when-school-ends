extends Node2D

var coins: int = 0

func add_coins(amount: int) -> void:
	coins += amount
	$CarGameUi/Coin/Label.text = str(coins)

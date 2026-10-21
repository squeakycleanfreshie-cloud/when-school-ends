extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

const CHARACTER_FRAMES = {
	"Chloe": preload("res://spriteframes/chloe.tres"),
	"Finn": preload("res://spriteframes/finn.tres"),
	"Hugo": preload("res://spriteframes/hugo.tres"),
	"Mia": preload("res://spriteframes/mia.tres"),
	"Oakley": preload("res://spriteframes/oakley.tres")
}

func _ready():
	pass

func change_character(character_name : String, is_talking : bool = true):
	animated_sprite.sprite_frames = CHARACTER_FRAMES[character_name]
	if is_talking:
		animated_sprite.play("talking")
	else:
		animated_sprite.play("idle")

func play_idle_animation():
	animated_sprite.play("idle")

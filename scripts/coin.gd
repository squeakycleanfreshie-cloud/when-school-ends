extends Area2D

@export var value: int = 5

func _on_body_entered(body: Node2D) -> void:
	print("entered: ", body.name, " groups: ", body.get_groups())
	if body.is_in_group("player"):
		print("player detected")
		get_tree().current_scene.add_coins(value)
		$AnimationPlayer.play("pickup")
		$CollisionShape2D.set_deferred("disabled", true)
		
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

func _ready() -> void:
	print("coin ready: ", name, " pos: ", global_position)

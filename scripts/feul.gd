extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("entered: ", body.name, " groups: ", body.get_groups())
	if body.is_in_group("player"):
		body.refuel()
		$AnimationPlayer.play("pickup")
		$CollisionShape2D.set_deferred("disabled", true)

func _on_animation_player_animation_finished(anim_name):
	queue_free()

extends Area2D

var done := false

func _on_body_entered(body: Node2D) -> void:
	print("finish touched by: ", body.name)
	if done:
		return
	if body.has_method("refuel"):
		done = true
		CarGame.finish(true)

extends Control

signal finished(success: bool)

@export var keyString: String = "Q"
@export var keyCode: Key = KEY_Q
@export var eventDuration := 0.5
@export var displayDuration := 0.5

@onready var color_rect: ColorRect = %ColorRect
@onready var key_label: Label = %KeyLabel
@onready var success_label: Label = %successLabel

var tween: Tween
var is_done := false

func _ready() -> void:
	add_to_group("QTE")
	key_label.text = keyString
	success_label.hide()
	_animation()

func _animation() -> void:
	var mat := color_rect.material as ShaderMaterial
	mat.set_shader_parameter("value", 1.0)

	tween = create_tween()
	tween.tween_property(color_rect, "material:shader_parameter/value", 0.0, eventDuration)
	tween.finished.connect(func(): _finish(false))

func _input(event: InputEvent) -> void:
	if is_done:
		return
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	if get_tree().get_nodes_in_group("QTE")[0] != self:
		return
	if event.keycode == keyCode:
		_finish(true)

func _finish(success: bool) -> void:
	if is_done:
		return
	is_done = true
	remove_from_group("QTE")
	if tween:
		tween.kill()
	if success:
		success_label.show()
	finished.emit(success)
	await get_tree().create_timer(displayDuration).timeout
	queue_free()
	

extends RigidBody2D

signal fuel_changed(value)

var wheels = []
var speed = 6000
var max_speed = 60
var fuel = 100
var dead = false

func _ready():
	wheels = get_tree().get_nodes_in_group("wheel")
	if not $GameOverTimer.timeout.is_connected(_on_game_over_timer_timeout):
		$GameOverTimer.timeout.connect(_on_game_over_timer_timeout)

func _physics_process(delta):
	if fuel > 0 && !dead:
		$GameOverTimer.stop()
		if Input.is_action_pressed("ui_right"):
			apply_torque_impulse(-6000 * delta * 60)
			use_fuel(delta)
			for wheel in wheels:
				if wheel.angular_velocity < max_speed:
					wheel.apply_torque_impulse(speed * delta * 60)
		if Input.is_action_pressed("ui_left"):
			apply_torque_impulse(2000 * delta * 60)
			use_fuel(delta)
			for wheel in wheels:
				if wheel.angular_velocity > -max_speed:
					wheel.apply_torque_impulse(-speed * delta * 60)
	else:
		if $GameOverTimer.is_stopped():
			$GameOverTimer.start()
	if $head.rotation_degrees > 90 || $head.rotation_degrees < -90 && !dead:
		dead = true
		$head/PinJoint2D.node_b = ""
func refuel():
	fuel = 100
	fuel_changed.emit(fuel)

func use_fuel(delta):
	fuel -= 10 * delta
	fuel = clamp(fuel, 0, 100)
	fuel_changed.emit(fuel)

func _on_game_over_timer_timeout() -> void:
	print("game over, reloading")
	get_tree().reload_current_scene()

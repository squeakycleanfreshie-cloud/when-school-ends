extends RigidBody2D

var wheels = []
var speed = 6000
var max_speed = 60
var fuel = 100

func _ready():
	wheels = get_tree().get_nodes_in_group("wheel")
	get_parent().update_feul_ui(fuel)

func _physics_process(delta):
	if fuel > 0:
		if Input.is_action_pressed("ui_right"):
			use_fuel(delta)
			for wheel in wheels:
				if wheel.angular_velocity < max_speed:
					wheel.apply_torque_impulse(speed * delta * 60)
		if Input.is_action_pressed("ui_left"):
			use_fuel(delta)
			for wheel in wheels:
				if wheel.angular_velocity > -max_speed:
					wheel.apply_torque_impulse(-speed * delta * 60)

func refuel():
	fuel = 100
	get_parent().update_feul_ui(fuel)

func use_fuel(delta):
	fuel -= 10 * delta
	fuel = clamp(fuel, 0, 100)
	get_parent().update_feul_ui(fuel)

extends RigidBody2D

export var force_strength = 50000
var start_pos
var dead = false


func _ready():
	start_pos = position

func pull_on(anchor, delta):
	apply_impulse(Vector2.ZERO, get_impulse(anchor, delta))
	if anchor is RigidBody2D:
		anchor.apply_impulse(Vector2.ZERO, -get_impulse(anchor, delta))

func push_on(anchor, delta):
	apply_impulse(Vector2.ZERO, -get_impulse(anchor, delta))
	if anchor is RigidBody2D:
		anchor.apply_impulse(Vector2.ZERO, get_impulse(anchor, delta))

func get_impulse(anchor, delta):
	return (anchor.position - position).normalized() * force_strength * delta

func die():
	dead = true
	
func _integrate_forces(state):
	if dead:
		state.transform = Transform2D(0, start_pos)
		state.linear_velocity = Vector2.ZERO
		dead = false

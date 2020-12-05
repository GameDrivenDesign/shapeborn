extends RigidBody2D

export var force_strength = 100000

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

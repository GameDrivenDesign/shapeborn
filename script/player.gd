extends RigidBody2D

export var force_strength = 100000

func pull_on(anchor, delta):
	apply_impulse(Vector2.ZERO, (anchor.position - position).normalized() * force_strength * delta)


func push_on(anchor, delta):
	apply_impulse(Vector2.ZERO, -(anchor.position - position).normalized() * force_strength * delta)

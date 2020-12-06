extends Node2D

var enabled = true

func on_entered(body: Node2D):
	if enabled and body.is_in_group("player"):
		body.die()

func enable(b):
	enabled = b
	visible = b

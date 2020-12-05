extends Node2D

func on_entered(body: Node2D):
	if body.is_in_group("player"):
		body.die()

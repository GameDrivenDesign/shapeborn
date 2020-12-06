extends Area2D

func _process(delta):
	position += Vector2.UP.rotated(rotation) * 1000.0 * delta


func _on_projectile_body_entered(body):
	if body.is_in_group("player"):
		body.dead = true
	queue_free()

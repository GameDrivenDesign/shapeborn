extends Area2D

func _on_box_killzone_body_entered(body):
	if body.is_in_group("die_on_impact"):
		body.queue_free()

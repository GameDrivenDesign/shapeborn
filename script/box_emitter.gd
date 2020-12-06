extends Node2D

func random_point():
	var shape = $Area2D/CollisionShape2D.shape
	return global_position + Vector2(
		rand_range(-shape.extents.x, shape.extents.x),
		rand_range(-shape.extents.y, shape.extents.y))

func _on_Timer_timeout():
	var box = preload("res://2d/MoveableObjectSmall.tscn").instance()
	box.position = random_point()
	box.rotation_degrees = rand_range(0, 360)
	get_parent().get_parent().add_child(box)

extends Area2D


export (NodePath) var door

func _ready():
	get_node(door).set_enabled(false)

func on_enter(body):
	if body.is_in_group("player"):
		get_node(door).set_enabled(true)

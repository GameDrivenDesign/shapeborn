tool
extends StaticBody2D

export var dark = false setget set_dark

func set_dark(b):
	dark = b
	modulate = Color(0.11, 0.11, 0.11) if dark else Color.white

func set_enabled(b):
	visible = b
	$CollisionShape2D.call_deferred("set_disabled", not b)

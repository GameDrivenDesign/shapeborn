tool
extends StaticBody2D

export var dark = false setget set_dark

func set_dark(b):
	dark = b
	modulate = Color(0.11, 0.11, 0.11) if dark else Color.white

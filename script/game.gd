extends Node2D

func _ready():
	$ViewportContainer.material.set_shader_param(
		"ViewportTexture",
		$ViewportContainer/Viewport.get_texture())

func set_zoom_strength(val):
	$ViewportContainer.material.set_shader_param(
		"ZoomStrength",
		val)

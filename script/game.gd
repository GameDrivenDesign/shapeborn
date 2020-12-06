extends Node2D

signal reset

func _ready():
	Global.start_time = OS.get_ticks_msec()
	
	$ViewportContainer.material.set_shader_param(
		"ViewportTexture",
		$ViewportContainer/Viewport.get_texture())

func set_zoom_strength(val):
	$ViewportContainer.material.set_shader_param(
		"ZoomStrength",
		val)

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		get_tree().change_scene("res://2d/gameover.tscn")

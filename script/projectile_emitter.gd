extends Node2D

var player
var active = false

const ACTIVATION_DISTANCE = 800 * 800

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	var is_close = global_position.distance_squared_to(player.global_position) < ACTIVATION_DISTANCE
	if not active and is_close:
		$Timer.start()
		active = true
	if active and not is_close:
		$Timer.stop()
		active = false

func _on_Timer_timeout():
	var projectile = preload("res://2d/projectile.tscn").instance()
	projectile.position = global_position
	projectile.rotation_degrees = global_rotation_degrees
	get_parent().get_parent().add_child(projectile)

extends KinematicBody2D

var next_step = true
var target_speed = 0
var current_speed = 0
var direction = 0

var hitpoints = 100

func _process(delta):
	if next_step:
		start_step()
	
	current_speed = lerp(current_speed, target_speed, delta)
	rotation_degrees += current_speed * direction * delta * 30

func start_step():
	next_step = false
	target_speed = rand_range(1.5, 3)
	direction = 1 if (randi() % 2) == 0 else -1
	yield (get_tree().create_timer(rand_range(1, 4)), "timeout")
	next_step = true

func take_damage():
	hitpoints -= 14
	if hitpoints <= 0:
		get_tree().change_scene("res://2d/gameover.tscn")

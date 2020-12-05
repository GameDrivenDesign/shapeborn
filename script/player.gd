extends RigidBody2D

export var force_strength = 50000
var start_pos
var dead = false
var anchors


func _ready():
	start_pos = position
	anchors = get_tree().get_nodes_in_group("anchor")
	
func _process(delta):
	var minAnchor = get_min_anchor()
	minAnchor.highlight(true)
	
	if Input.is_action_just_pressed("slow_time"):
		slow_time()

const SLOW_FACTOR = 0.3
func slow_time():
	$slow_time_tween.interpolate_property(Engine, "time_scale", 1, SLOW_FACTOR, 0.5, Tween.TRANS_EXPO)
	$slow_time_tween.start()
	yield($slow_time_tween, "tween_completed")
	yield(get_tree().create_timer(1 * SLOW_FACTOR), "timeout")
	$slow_time_tween.interpolate_property(Engine, "time_scale", SLOW_FACTOR, 1, 2, Tween.TRANS_EXPO)
	$slow_time_tween.start()
	yield($slow_time_tween, "tween_completed")

func get_min_anchor():
	var minAnchor = anchors[0]
	var minDistance = anchors[0].get_local_mouse_position().length()
	for anchor in anchors:
		var distance = anchor.get_local_mouse_position().length()
		if distance < minDistance:
			minDistance = distance
			minAnchor = anchor
	return minAnchor

func pull_on(anchor, delta):
	apply_impulse(Vector2.ZERO, get_impulse(anchor, delta))
	if anchor is RigidBody2D:
		anchor.apply_impulse(Vector2.ZERO, -get_impulse(anchor, delta))

func push_on(anchor, delta):
	apply_impulse(Vector2.ZERO, -get_impulse(anchor, delta))
	if anchor is RigidBody2D:
		anchor.apply_impulse(Vector2.ZERO, get_impulse(anchor, delta))

func get_impulse(anchor, delta):
	return (anchor.position - position).normalized() * force_strength * delta

func die():
	dead = true
	
func _integrate_forces(state):
	if dead:
		state.transform = Transform2D(0, start_pos)
		state.linear_velocity = Vector2.ZERO
		dead = false

func _on_slow_time_tween_tween_step(object, key, elapsed, value):
	get_node("/root/game").set_zoom_strength(1 - value)
	Engine.time_scale = value

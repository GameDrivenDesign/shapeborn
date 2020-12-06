extends RigidBody2D

export var force_strength = 50000
export var max_velocity = 1000
export var max_distance = 400

var start_pos
var dead = false

var selected_anchor
var highlighted_anchor

var last_checkpoint
var time_is_slow = false

func _ready():
	if OS.has_feature("standalone"):
		position = get_parent().get_node("startPoint").position
	start_pos = position

func _process(delta):
	update_anchors(delta)
	
	if Input.is_action_just_pressed("respawn_at_checkpoint"):
		dead = true
	
	if Input.is_action_just_pressed("slow_time") and not time_is_slow :
		slow_time()

func update_anchors(delta):
	var anchors = get_anchors()
	if (Input.is_action_just_pressed("mouse_left") 
		or Input.is_action_just_pressed("mouse_right")) and highlighted_anchor != null:
		set_selected_anchor(highlighted_anchor)
	
	if (Input.is_action_just_released("mouse_left") 
		or Input.is_action_just_released("mouse_right")) and selected_anchor != null:
		set_selected_anchor(null)
	
	if selected_anchor != null and Input.is_action_pressed("mouse_left"):
		pull_on(selected_anchor, delta)
	
	if selected_anchor != null and Input.is_action_pressed("mouse_right"):
		push_on(selected_anchor, delta)
		
	# Update highlight
	if selected_anchor == null:
		var min_anchor = get_min_anchor(anchors)
		set_highlighted_anchor(min_anchor)
	else:
		# Deselect anchor if too far away. Don't highlight or select other anchor
		if mouse_dist(selected_anchor) > max_distance:
			set_selected_anchor(null)
			
func set_highlighted_anchor(anchor):
	var anchors = get_anchors()
	highlighted_anchor = anchor
	if anchor != null:
		highlighted_anchor.highlight(true)
	for other in anchors:
		if other != highlighted_anchor:
			other.highlight(false)

func set_selected_anchor(anchor):
	var anchors = get_anchors()
	selected_anchor = anchor
	if anchor != null:
		selected_anchor.select(true)
	for other in anchors:
		if other != selected_anchor:
			other.select(false)

const SLOW_FACTOR = 0.3
func slow_time():
	time_is_slow = true
	$slow_time_tween.interpolate_property(Engine, "time_scale", 1, SLOW_FACTOR, 0.5, Tween.TRANS_EXPO)
	$slow_time_tween.start()
	yield($slow_time_tween, "tween_completed")
	yield(get_tree().create_timer(1 * SLOW_FACTOR), "timeout")
	$slow_time_tween.interpolate_property(Engine, "time_scale", SLOW_FACTOR, 1, 2, Tween.TRANS_EXPO)
	$slow_time_tween.start()
	yield($slow_time_tween, "tween_completed")
	time_is_slow = false

func mouse_dist(obj):
	 return obj.get_local_mouse_position().length()

func get_min_anchor(anchors):
	var minAnchor = anchors[0]
	var minDistance = mouse_dist(anchors[0])
	for anchor in anchors:
		var distance = mouse_dist(anchor)
		if distance < minDistance:
			minDistance = distance
			minAnchor = anchor
	if minDistance > max_distance:
		return null
	return minAnchor

func get_anchors():
	return get_tree().get_nodes_in_group("anchor")

func pull_on(anchor, delta):
	apply_impulse(Vector2.ZERO, get_impulse(anchor, delta))
	if anchor is RigidBody2D:
		anchor.apply_impulse(Vector2.ZERO, -get_impulse(anchor, delta))
		anchor.update()

func push_on(anchor, delta):
	apply_impulse(Vector2.ZERO, -get_impulse(anchor, delta))
	if anchor is RigidBody2D:
		anchor.apply_impulse(Vector2.ZERO, get_impulse(anchor, delta))
		anchor.update()

func get_impulse(anchor, delta):
	return (anchor.global_position - global_position).normalized() * force_strength * delta

func die():
	dead = true

func _integrate_forces(state):
	if state.linear_velocity.length() > max_velocity:
		state.linear_velocity = state.linear_velocity.normalized() * max_velocity
	
	if dead:
		state.transform = Transform2D(0, last_checkpoint.get_spawn_position() if last_checkpoint else start_pos)
		state.linear_velocity = Vector2.ZERO
		dead = false
	
	var velocity = state.linear_velocity.length()
	$movement_particles.emitting = velocity > 50.0

func _on_slow_time_tween_tween_step(object, key, elapsed, value):
	get_node("/root/game").set_zoom_strength(1 - value)
	Engine.time_scale = value

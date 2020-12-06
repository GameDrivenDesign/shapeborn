extends StaticBody2D

export (float) var damage_multiplier = 0.0002
export (float) var max_damage = 0.2

var health = 1
var health_bar_full
var start_time

var state_duration = 5000
var states = 2

var started = false
var running = false
var prev_state = -1

func _ready():
	health_bar_full = $Health.scale.x
	$Lava/Lava.enable(false)

func _process(delta):
	if not running:
		return
	
	var state = get_state()
	var percentage = get_state_percentage()
	var first = prev_state != state
	
	if first:
		call_state(prev_state, percentage, false, true)
		prev_state = state
		
	call_state(state, percentage, first, false)

func call_state(i, percentage, first, last):
	if i == 0:
		state_idle(percentage, first, last)
	if i == 1:
		state_lava(percentage, first, last)
	
func state_idle(percentage, first, last):
	pass

func state_lava(percentage, first, last):
	if first:
		$Lava/Lava.enable(true)
	if last:
		$Lava/Lava.enable(false)
		return
	$Lava.rotation_degrees = percentage * 180
	
func start():
	if not started:
		start_time = OS.get_ticks_msec()
		started = true
		running = true

func get_state():
	var time = OS.get_ticks_msec() - start_time
	return (time % (state_duration * states)) / state_duration

func get_state_percentage():
	var time = OS.get_ticks_msec() - start_time
	return (time % state_duration) / float(state_duration)

func set_health(health):
	if health <= 0:
		die()
		
	health = max(0, health)
	self.health = health
	$Health.scale.x = lerp(0, health_bar_full, health)

func die():
	visible = false
	running = false
	$"../Win".visible = true

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		set_health(health - min(body.linear_velocity.length() * damage_multiplier, max_damage))

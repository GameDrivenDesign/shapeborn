extends "res://script/anchor.gd"

export(NodePath) var end
export var half_travel_duration_msec = 4000
export var stop_time_msec = 2000
var start_pos

func _ready():
	start_pos = position

func _process(delta):
	var end_pos = get_node(end).position
	var time = OS.get_ticks_msec()
	var progress = time % (half_travel_duration_msec * 2 + stop_time_msec)
	
	if progress > half_travel_duration_msec + stop_time_msec:
		progress = half_travel_duration_msec - (progress - (half_travel_duration_msec + stop_time_msec))
	elif progress > half_travel_duration_msec:
		progress = half_travel_duration_msec
		
	var linear = float(progress) / half_travel_duration_msec
	
	position = lerp(start_pos, end_pos, pow(linear, 2))

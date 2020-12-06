extends Node2D

var highlighted = false
var selected = false
var player
var others

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	others = get_tree().get_nodes_in_group("anchor")
	others.remove(others.find(self))

func highlight(highlighted):
	if highlighted:
		for o in others:
			o.highlight(false)
	else:
		selected = false
		update()
	
	self.highlighted = highlighted
	show_highlight(highlighted)

func _process(delta):
	if (Input.is_action_just_pressed("mouse_left") 
		or Input.is_action_just_pressed("mouse_right")) and highlighted:
		selected = true
	
	if (Input.is_action_just_released("mouse_left") 
		or Input.is_action_just_released("mouse_right")) and selected:
		selected = false
		update()
		if not highlighted:
			show_highlight(false)
	
	if selected and Input.is_action_pressed("mouse_left"):
		player.pull_on(self, delta)
		update()
	
	if selected and Input.is_action_pressed("mouse_right"):
		player.push_on(self, delta)
		update()

func _draw():
	if selected:
		var end = (player.global_position - global_position).rotated(-rotation)
		var start = Vector2.ZERO
		# start the line just "outside" the player
		end -= end.normalized() * 50
		
		var arrow_distance = 20
		var step = end.normalized() * arrow_distance
		var arrow_dir = end.normalized() * 10
		
		var num_steps = (end - start).length() / arrow_distance
		var inverted = Input.is_action_pressed("mouse_right")
		var color = Color(0.6, 0.6, 2.3) if inverted else Color(0.1, 1.7, 0.1)
		for i in range(num_steps):
			draw_line(start, start + arrow_dir.rotated(deg2rad(180 - 45 if inverted else 45)), color, 5)
			draw_line(start, start + arrow_dir.rotated(deg2rad(180 + 45 if inverted else -45)), color, 5)
			start += step

func show_highlight(show):
	$SelectedSprite.visible = show
	$Sprite.visible = !show

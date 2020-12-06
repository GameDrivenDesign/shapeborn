extends Node2D

var highlighted = false
var selected = false
var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func highlight(highlighted):
	self.highlighted = highlighted
	show_highlight(highlighted)

func select(selected):
	if not selected:
		highlight(false)
	self.selected = selected
	update()

func _process(delta):
	if selected:
		update()

func _draw():
	if selected:
		var end = (player.global_position - global_position).rotated(-global_rotation)
		var start = Vector2.ZERO
		# end the line just "outside" the player
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

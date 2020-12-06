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
	
	self.highlighted = highlighted
	show_highlight(highlighted)

func _process(delta):
	if (Input.is_action_just_pressed("mouse_left") 
		or Input.is_action_just_pressed("mouse_right")) and highlighted:
		selected = true
	
	if (Input.is_action_just_released("mouse_left") 
		or Input.is_action_just_released("mouse_right")) and selected:
		selected = false
		if not highlighted:
			show_highlight(false)
	
	if selected and Input.is_action_pressed("mouse_left"):
		player.pull_on(self, delta)
	
	if selected and Input.is_action_pressed("mouse_right"):
		player.push_on(self, delta)

func show_highlight(show):
	$SelectedSprite.visible = show
	$Sprite.visible = !show

extends Node


export(NodePath) var player

var highlighted = false


func _ready():
	pass

func on_mouse_entered():
	$Body/SelectedSprite.visible = true
	$Body/Sprite.visible = false
	highlighted = true

func on_mouse_exited():
	$Body/SelectedSprite.visible = false
	$Body/Sprite.visible = true
	highlighted = false

func _process(delta):
	if Input.is_action_pressed("mouse_left") and highlighted:
		get_node(player).pull_on(self, delta)
	if Input.is_action_pressed("mouse_right") and highlighted:
		
		get_node(player).push_on(self, delta)

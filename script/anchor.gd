extends Node2D

var highlighted = false

func _ready():
	pass

func on_mouse_entered():
	print("enter")
	$SelectedSprite.visible = true
	$Sprite.visible = false
	highlighted = true

func on_mouse_exited():
	$SelectedSprite.visible = false
	$Sprite.visible = true
	highlighted = false

func _process(delta):
	if Input.is_action_pressed("mouse_left") and highlighted:
		$"../Player".pull_on(self, delta)
	if Input.is_action_pressed("mouse_right") and highlighted:
		$"../Player".push_on(self, delta)

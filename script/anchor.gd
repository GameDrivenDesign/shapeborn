extends Node2D

var highlighted = false
var selected = false

func _ready():
	pass

func on_mouse_entered():
	show_highlight(true)
	highlighted = true

func on_mouse_exited():
	if not selected:
		show_highlight(false)
	highlighted = false

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
		$"../Player".pull_on(self, delta)
	
	if selected and Input.is_action_pressed("mouse_right"):
		$"../Player".push_on(self, delta)

func show_highlight(show):
	$SelectedSprite.visible = show
	$Sprite.visible = !show

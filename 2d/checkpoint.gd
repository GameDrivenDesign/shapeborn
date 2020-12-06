extends Area2D

var activated = false

func _ready():
	$Label.visible = false

func _on_checkpoint_body_entered(body):
	if body.is_in_group("player") and not activated:
		activated = true
		$Label.visible = true
		body.last_checkpoint = self

func get_spawn_position():
	return $spawn_point.global_position

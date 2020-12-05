extends Node2D


var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func on_entered(body: Node2D):
	if body == player:
		player.die()

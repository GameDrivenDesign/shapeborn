extends StaticBody2D


var PIECE = preload("res://2d/Piece.tscn")
var LAST = preload("res://2d/MoveableAnchor.tscn")

export (int) var pieces = 1

func _ready():
	var parent = self
	for i in range(pieces):
		parent = add_piece(parent)
	var joint = parent.get_node("body/joint")
	var last = LAST.instance()
	joint.add_child(last)
	joint.node_a = parent.get_path()
	joint.node_b = last.get_path()

func add_piece(parent):
	var joint = parent.get_node("body/joint")
	var piece = PIECE.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece

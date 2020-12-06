extends RigidBody2D


var PIECE = preload("res://2d/Piece.tscn")

export (NodePath) var last
export (int) var pieces = 1

func _ready():
	var parent = self
	for i in range(pieces):
		parent = add_piece(parent)
	var joint = parent.get_node("joint")
	joint.add_child(get_node(last))
	joint.node_a = parent.get_path()
	joint.node_b = last

func add_piece(parent):
	var joint = parent.get_node("joint")
	var piece = PIECE.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece

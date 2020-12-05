extends RigidBody

const SPEED = 3000
var mouseDelta = Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func move_vec(vec):
	add_force(vec, Vector3.ZERO)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		move_vec($CameraPivot.global_transform.basis.x * delta * -SPEED)
	if Input.is_action_pressed("ui_right"):
		move_vec($CameraPivot.global_transform.basis.x * delta * SPEED)
	if Input.is_action_pressed("ui_up"):
		move_vec($CameraPivot.global_transform.basis.z * delta * -SPEED)
	if Input.is_action_pressed("ui_down"):
		move_vec($CameraPivot.global_transform.basis.z * delta * SPEED)
	if Input.is_action_pressed("ui_accept"):
		move_vec($CameraPivot.global_transform.basis.y * delta * SPEED)
	
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * 15.0 * -delta
	$CameraPivot.rotation_degrees.x += rot.x
	$CameraPivot.rotation_degrees.x = clamp($CameraPivot.rotation_degrees.x, -75, 20)
	$CameraPivot.rotation_degrees.y += rot.y
	
	# rotation_degrees.y -= rot.y
	mouseDelta = Vector2.ZERO

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

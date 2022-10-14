extends KinematicBody

# parameters
export var moveSpeed = 150
export var gravity = 98*4
export var sensitivity = 0.004

# variables
var velocity = Vector3()

# Built-in Functions
func _input(event):
	# Camera Rotation
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * sensitivity)

		var camNode = get_node("/root/subRoot/3D World/Player/Camera")
		camNode.rotate_x(-event.relative.y * sensitivity)
		camNode.rotation.x = clamp(camNode.rotation.x * 180/PI, -60, 60)* PI/180

func _ready():
	# Cursor Lock
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Player Movement

	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction = direction - transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction = direction + transform.basis.z
	if Input.is_action_pressed("move_right"):
		direction = direction + transform.basis.x
	if Input.is_action_pressed("move_left"):
		direction = direction - transform.basis.x
	if Input.is_action_pressed("jump"):
		if self.is_on_floor():
			gravity = gravity*-1
			
	direction = direction.normalized() * moveSpeed

	velocity.x = direction.x
	velocity.z = direction.z
	velocity.y = velocity.y - gravity

	velocity = self.move_and_slide(velocity*delta, Vector3.UP)
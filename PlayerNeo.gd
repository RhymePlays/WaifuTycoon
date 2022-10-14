extends KinematicBody

# parameters
export var gravity = -9.8
export var moveSpeed = 100
export var jumpPower = 4
export var sensitivity = 0.004

var controlsEnabled = true

# variables
var velocity = Vector3.ZERO

# functions
func _input(event):
	# Camera Rotation
	if event is InputEventMouseMotion and controlsEnabled:
		self.rotate_y(-event.relative.x * sensitivity)

		var camNode = get_node("/root/subRoot/3D World/Player/Camera")
		camNode.rotate_x(-event.relative.y * sensitivity)
		camNode.rotation.x = deg2rad((clamp(rad2deg(camNode.rotation.x), -60, 60)))

func getInputWeight():
	var inputWeight = Vector3.ZERO
	inputWeight.x = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	inputWeight.z = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if get_node("/root/subRoot/UI/TouchControls/ButtonW").pressed: inputWeight.x = 1 #UI BUTTON
	if get_node("/root/subRoot/UI/TouchControls/ButtonA").pressed: inputWeight.z = -1 #UI BUTTON
	if get_node("/root/subRoot/UI/TouchControls/ButtonS").pressed: inputWeight.x = -1 #UI BUTTON
	if get_node("/root/subRoot/UI/TouchControls/ButtonD").pressed: inputWeight.z = 1 #UI BUTTON

	if inputWeight.length() > 1:
		return inputWeight.normalized()
	else:
		return inputWeight

func getDirection(inputWeight):
	var direction = (inputWeight.x * -transform.basis.z) + (inputWeight.z * transform.basis.x)
	return direction

func _physics_process(_delta):
	if controlsEnabled:
		var inputWeight = getInputWeight()
		var direction = getDirection(inputWeight)
		
		velocity.x = direction.x * moveSpeed * _delta
		velocity.z = direction.z * moveSpeed * _delta
		velocity.y = velocity.y + gravity * _delta;velocity.y = clamp(velocity.y, gravity, jumpPower)
		if Input.is_action_just_pressed("jump") or get_node("/root/subRoot/UI/TouchControls/ButtonSpace").pressed: if self.is_on_floor(): velocity.y = jumpPower #UI BUTTON

		velocity = move_and_slide(velocity, Vector3.UP)


		# RayCast_Interactor
		if ($Camera/RayCast.get_collider() is StaticBody):
			if $Camera/RayCast.get_collider().has_method("interact"):
				get_node("/root/subRoot/UI/Crosshair").modulate = Color.lime
				if Input.is_action_just_pressed("accept") or get_node("/root/subRoot/UI/TouchControls/ButtonE").pressed: $Camera/RayCast.get_collider().interact() #UI BUTTON
		else:
			get_node("/root/subRoot/UI/Crosshair").modulate = Color.white

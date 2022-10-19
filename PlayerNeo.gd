extends KinematicBody

# Parameters
export var gravity = -9.8
export var moveSpeed = 100
export var jumpPower = 4
export var sensitivity = 0.004
export var respwanPoint = Vector3(-2.5, 1.6, -1.5)
export var userOfXPlace = "GreenPlace"


# Variables
var velocity = Vector3.ZERO
var controlsEnabled = true


# Functions
func killPlayer():
	self.transform.origin = respwanPoint

func getInputWeight():
	var inputWeight = Vector3.ZERO
	inputWeight.x = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	inputWeight.z = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if inputWeight.length() > 1:
		return inputWeight.normalized()
	else:
		return inputWeight

func getDirection(inputWeight):
	var direction = (inputWeight.x * -transform.basis.z) + (inputWeight.z * transform.basis.x)
	return direction


# Default Functions
func _input(event):
	# Camera Rotation
	if controlsEnabled and (event is InputEventMouseMotion):
		self.rotate_y(-event.relative.x * sensitivity)

		var camNode = $Camera
		camNode.rotate_x(-event.relative.y * sensitivity)
		camNode.rotation.x = deg2rad((clamp(rad2deg(camNode.rotation.x), -60, 60)))

func _physics_process(_delta):
	if controlsEnabled:
		var inputWeight = getInputWeight()
		var direction = getDirection(inputWeight)
		
		velocity.x = direction.x * moveSpeed * _delta
		velocity.z = direction.z * moveSpeed * _delta
		velocity.y = velocity.y + gravity * _delta;velocity.y = clamp(velocity.y, gravity, jumpPower)
		if Input.is_action_just_pressed("jump"): if self.is_on_floor(): velocity.y = jumpPower

		velocity = move_and_slide(velocity, Vector3.UP)

		
		# Raycast Interactor
		if $Camera/RayCast.is_colliding():

			if typeof($Camera/RayCast.get_collider().get("interactableByUsersOfXPlace")) != TYPE_STRING:
				if $Camera/RayCast.get_collider().has_method("interact"):
					get_node("/root/subRoot/UI/Crosshair").modulate = Color("#25ffb1")
					if Input.is_action_just_pressed("accept"): $Camera/RayCast.get_collider().interact()
				else:
					get_node("/root/subRoot/UI/Crosshair").modulate = Color("1badff")
			
			elif $Camera/RayCast.get_collider().get("interactableByUsersOfXPlace") == userOfXPlace:
				get_node("/root/subRoot/UI/Crosshair").modulate = Color("#25ffb1")
				if Input.is_action_just_pressed("accept"): $Camera/RayCast.get_collider().interact()
			
			else:
				get_node("/root/subRoot/UI/Crosshair").modulate = Color("1badff")	
		
		else:
			get_node("/root/subRoot/UI/Crosshair").modulate = Color("1badff")
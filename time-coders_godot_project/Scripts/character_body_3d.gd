extends CharacterBody3D

const JUMP_VELOCITY = 4.5

@export var _walking_speed :float = 1
@export var _acceleration : float = 2
@export var _deceleration : float = 4
var _xz_velocity : Vector3

@onready var _animation : AnimationTree = $AnimationTree

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _direction: Vector3 = Vector3.ZERO

func move(direction: Vector3):
	# Set the movement direction
	_direction = direction

func _physics_process(delta: float):
	_xz_velocity = Vector3(velocity.x, 0, velocity.z)
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0  # Reset vertical velocity when on the floor

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Update movement velocity based on direction
	if _direction:
		_xz_velocity = _xz_velocity.move_toward(_direction * _walking_speed, _acceleration * delta)
	else:
		_xz_velocity = _xz_velocity.move_toward(Vector3.ZERO, _deceleration * delta)
		
	_animation.set("parameters/Locomotion/blend_position", _xz_velocity.length() / _walking_speed)	
	
	velocity.x = _xz_velocity.x
	velocity.z = _xz_velocity.z

	# Move the character using the built-in velocity
	move_and_slide()

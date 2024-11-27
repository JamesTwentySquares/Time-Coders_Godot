extends CharacterBody3D


const JUMP_VELOCITY = 4.5

@export var _walking_speed :float = 1
@export var _running_speed :float = 2
@export var _acceleration : float = 2
@export var _deceleration : float = 4
@export var _rotation_speed : float = PI * 2
var _movement_speed : float = _walking_speed
var _angle_difference : float
var _xz_velocity : Vector3

@onready var _animation : AnimationTree = $AnimationTree
@onready var _rig : Node3D = $Rig

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _direction: Vector3 


func move(direction: Vector3):
	# Set the movement direction
	_direction = direction
	
func walk():
	_movement_speed = _walking_speed
	
func run():
	_movement_speed = _running_speed	

func _physics_process(delta: float):
	if _direction:
		_angle_difference = wrapf(atan2(_direction.x, _direction.z) - _rig.rotation.y, -PI, PI)
		_rig.rotation.y += clamp(_rotation_speed * delta, 0, abs(_angle_difference)) * sign(_angle_difference)
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
		if _direction.dot(velocity) >= 0:
			_xz_velocity = _xz_velocity.move_toward(_direction * _movement_speed, _acceleration * delta)
		else:
			_xz_velocity = _xz_velocity.move_toward(_direction * _movement_speed, _deceleration * delta)
	else:
		_xz_velocity = _xz_velocity.move_toward(Vector3.ZERO, _deceleration * delta)
		
	_animation.set("parameters/Locomotion/blend_position", _xz_velocity.length() / _running_speed)	
	
	velocity.x = _xz_velocity.x
	velocity.z = _xz_velocity.z

	# Move the character using the built-in velocity
	move_and_slide()

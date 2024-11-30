extends CharacterBody3D

@export_category("Locomotion")
@export var _walking_speed : float = 1
@export var _running_speed : float = 2
@export var _acceleration : float = 4
@export var _deceleration : float = 6
@export var _rotation_speed : float = PI * 2
var _movement_speed : float = _walking_speed
var _angle_difference : float
var _xz_velocity : Vector3
var _direction: Vector3

@export_category("Jumping")
@export var _jump_height : float = 3.8
@export var _mass : float = 1
var _jump_velocity : float
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var _animation : AnimationTree = $AnimationTree
@onready var _state_machine : AnimationNodeStateMachinePlayback = _animation["parameters/playback"]
@onready var _rig : Node3D = $Rig

func _ready():
	_jump_velocity = sqrt(_jump_height * _gravity * _mass * 2)

func move(direction: Vector3):
	# Set the movement direction
	_direction = direction

func walk():
	_movement_speed = _walking_speed

func run():
	_movement_speed = _running_speed	

func jump():
	if is_on_floor():
		_state_machine.travel("Jump_Start")

func _apply_jump_velocity():
		velocity.y = _jump_velocity

func _physics_process(delta: float):
	if _direction:
		_angle_difference = wrapf(atan2(_direction.x, _direction.z) - _rig.rotation.y, -PI, PI)
		_rig.rotation.y += clamp(_rotation_speed * delta, 0, abs(_angle_difference)) * sign(_angle_difference)

	# Applying gravity if not on the floor
	if not is_on_floor():
		velocity.y -= _gravity * _mass * delta

	# Apply movement
	if _direction.length() > 0:  # There is movement input
		# Accelerate towards the movement direction
		_xz_velocity = _xz_velocity.move_toward(_direction * _movement_speed, _acceleration * delta)
	else:  # No movement input, decelerate
		_xz_velocity = _xz_velocity.move_toward(Vector3.ZERO, _deceleration * delta)

	# Update animation blend (this may need further tuning)
	_animation.set("parameters/Locomotion/blend_position", _xz_velocity.length() / _running_speed)

	# Apply the final movement velocity
	velocity.x = _xz_velocity.x
	velocity.z = _xz_velocity.z

	# Move the character using the built-in move_and_slide()
	move_and_slide()

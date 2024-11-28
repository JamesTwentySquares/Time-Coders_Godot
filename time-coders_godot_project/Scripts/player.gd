extends Node

@export var _character: CharacterBody3D
@export var _camera: Camera3D

var _input_direction: Vector2

func _input(event: InputEvent):
	if event.is_action_pressed("run"):
		_character.run()
	elif event.is_action_released("run"):
		_character.walk()
	elif event.is_action_pressed("jump"):
		_character.jump()

func _process(delta: float):
	# Get input direction from user
	_input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	# Convert input direction to world direction using the camera
	var forward = (_camera.basis.z * Vector3(1, 0, 1)).normalized()
	var right = (_camera.basis.x * Vector3(1, 0, 1)).normalized()
	var move_direction = (right * _input_direction.x + forward * _input_direction.y).normalized()

	# Pass the calculated movement direction to the character body
	_character.move(move_direction)

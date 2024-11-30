extends Area3D


@onready var parent = get_parent()  # Reference to the parent Node3D

func _ready():
	# Connect the body_entered signal to the local method _on_body_entered
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):  # Check if the colliding body is the player
		parent.collect()  # Call the parent node's collect method

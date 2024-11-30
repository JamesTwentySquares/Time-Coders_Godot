extends Node3D

@export var item_name: String = "Default Item"  # Name of the collectible
@export var value: int = 1                     # Value of the collectible (e.g., score or inventory)

signal collected(item_name: String, value: int)  # Signal emitted when collected

func collect():
	# Emit the collected signal
	emit_signal("collected", item_name, value)
	# Remove the collectible from the scene
	queue_free()


func _on_collected(item_name: String, value: int) -> void:
	pass # Replace with function body.

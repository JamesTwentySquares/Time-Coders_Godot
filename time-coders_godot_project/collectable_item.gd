extends Area3D

@export var item_name: String = "Default Item"
@export var value: int = 1  # Value of the item, e.g., for a score or inventory

signal collected(item_name: String, value: int)

func _ready():
	# Enable monitoring for collisions
	self.monitoring = true

func _on_area_entered(area: Node):
	if area.is_in_group("Player"):  # Check if the colliding object is the player
		emit_signal("collected", item_name, value)  # Signal that the item was collected
		queue_free()  # Remove the item from the scene

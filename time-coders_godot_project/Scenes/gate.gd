extends Node3D

@onready var gate_mesh = $MeshInstance3D  # The gate's visual mesh
@onready var gate_collider = $CollisionShape3D  # The gate's collision shape

@onready var game_manager = get_node("../GameManager")  # GameManager is a sibling of Gate

func _ready():
	print("Gate is ready.")
	
	# Ensure gate mesh is visible at the start
	if gate_mesh:
		gate_mesh.visible = true
		print("Gate mesh is initially visible.")
	else:
		print("ERROR: Gate mesh not found.")
	
	# Ensure collider is active at the start
	if gate_collider:
		gate_collider.disabled = false
		print("Gate collider is initially active.")
	else:
		print("ERROR: Gate collider not found.")
	
	# Connect to the GameManager signal
	if game_manager and game_manager.has_signal("all_coins_collected"):
		game_manager.connect("all_coins_collected", Callable(self, "_open_gate"))
		print("Connected to GameManager signal.")
	else:
		print("ERROR: Failed to connect to GameManager signal.")

func _open_gate():
	print("Gate is opening...")
	# Hide the gate's mesh
	if gate_mesh:
		gate_mesh.visible = false
		print("Gate mesh is now hidden.")
	else:
		print("ERROR: Gate mesh not found during opening.")
	
	# Disable the gate's collider
	if gate_collider:
		gate_collider.disabled = true
		print("Gate collider is now disabled.")
	else:
		print("ERROR: Gate collider not found during opening.")
	
	# Optionally free the gate node
	queue_free()
	print("Gate has been removed from the scene.")

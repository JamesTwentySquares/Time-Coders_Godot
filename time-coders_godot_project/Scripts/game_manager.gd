extends Node

@onready var coins = get_tree().get_nodes_in_group("coins")  # Get all coins in the scene

func _ready():
	# Connect the "collected" signal from each coin to the _on_coin_collected method
	for coin in coins:
		coin.connect("collected", Callable(self, "_on_coin_collected"))
	
func _on_coin_collected(item_name: String, value: int):
	# Handle the collected coin (e.g., increase score, update coin count)
	print("Collected: ", item_name, " Value: ", value)

	# Check if all coins are collected
	var collected_coins = get_tree().get_nodes_in_group("coins").size()
	if collected_coins == 0:
		# If all coins are collected, destroy the gate
		var gate = get_node("/root/GameManager/Gate")  # Or wherever the gate is in the scene
		gate.queue_free()


func _on_collectable_collected(item_name: String, value: int) -> void:
	pass # Replace with function body.

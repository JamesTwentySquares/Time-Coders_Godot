extends Node

@export var total_coins = 0
var coins_collected = 0

signal all_coins_collected

func _ready():
	print("GameManager initialized.")
	print("Total coins in the level:", total_coins)
	coins_collected = 0

func _on_coin_collected():
	coins_collected += 1
	print("Coin collected. Total collected:", coins_collected)
	print("Checking coin collection status: Collected =", coins_collected, "Total =", total_coins)
	
	if coins_collected >= total_coins:
		print("All coins collected. Emitting signal...")
		emit_signal("all_coins_collected")

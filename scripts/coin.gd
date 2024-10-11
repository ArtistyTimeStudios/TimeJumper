extends Node

const Coin = preload("res://scenes/coin.tscn")  # Ensure you're referencing the coin scene
@onready var spawn_timer: Timer = $SpawnTimer
@onready var camera_2d: Camera2D = $"../Player/Camera2D"

# The distance at which coins will be spawned ahead of the camera
var spawn_distance: float = 500.0
var coins_spawned: Array = []
var initial_camera_y: float = 0.0  # To store the camera's initial y position

func _ready():
	# Store the camera's initial y position
	initial_camera_y = camera_2d.global_position.y

	# Connect the spawn timer
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.wait_time = 1.0 # Set the wait time to control spawning frequency
	spawn_timer.start()

# This function is called whenever the spawn timer times out
func _on_spawn_timer_timeout():
	var camera_position = camera_2d.global_position
	
	# Use the initial_camera_y to spawn coins on the same y level as the initial camera position
	var spawn_position = Vector2(camera_position.x + spawn_distance, initial_camera_y)
	
	# Create an instance of the coin scene and add it to the current scene
	var new_coin = Coin.instantiate()
	add_child(new_coin)
	new_coin.global_position = spawn_position
	
	# Connect the signal to detect collision with the player
	new_coin.connect("area_entered", Callable(self, "_on_coin_collected"))
	
	# Keep track of coins spawned
	coins_spawned.append(new_coin)

# This function is called when a coin is collected (on collision)
func _on_coin_collected(area):
	# Assume 'area' is the player who collected the coin
	for coin in coins_spawned:
		# Check if the coin is the one that was collided with
		if coin.has_point(area.global_position):
			coins_spawned.erase(coin)  # Remove from the list
			coin.queue_free()  # Remove the coin from the scene
		

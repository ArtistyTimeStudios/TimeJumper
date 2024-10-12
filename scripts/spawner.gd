extends Node

const COIN = preload("res://scenes/coin.tscn")
const Enemy_1 = preload("res://scenes/enemy.tscn")
@onready var spawn_timer: Timer = $SpawnTimer
@onready var camera_2d: Camera2D = $"../Player/Camera2D"
@onready var game_data: Node = get_node("/root/Game/GameData")  # Access the game data to check game_over state
# The distance at which enemies will be spawned ahead of the camera
var spawn_distance: float = 500.0
var enemies_spawned: Array = []
var enemy_speed: float = 50.0  # Speed at which the enemies will move to the left
var min_spawn_time: float = 1.0  # Minimum wait time between spawns (in seconds)
var max_spawn_time: float = 5.0  # Maximum wait time between spawns (in seconds)

func _ready():
	# Seed the random number generator
	randomize()
	spawn_timer.wait_time = 0.1  # Initial spawn time, but will randomize after first spawn
	spawn_timer.start()

# This function is called whenever the spawn timer times out
func _on_spawn_timer_timeout():
	if game_data.game_over:  # Stop spawning enemies if the game is over
		return

	var camera_position = camera_2d.global_position
	var min_spacing: int = 200  # Minimum distance between spawns
	var max_spacing: int = 600  # Maximum distance between spawns
	var random_spacing = randi_range(min_spacing, max_spacing)
	
	# Common spawn X position
	var spawn_x_position = camera_position.x + spawn_distance + random_spacing

	# Decide whether to spawn a coin or an enemy
	if randf() < 0.2:  # 20% chance to spawn a coin
		# Adjust the Y position to spawn above the ground level
		var ground_y_position = 1  # Adjust this based on your actual ground level in the game
		var offset_above_ground = randf_range(0, 60)  # Random height above ground
		var random_y_position = ground_y_position - offset_above_ground
		var spawn_position = Vector2(spawn_x_position, random_y_position)
		var new_coin = COIN.instantiate()
		add_child(new_coin)
		new_coin.global_position = spawn_position
	else:  # 80% chance to spawn an enemy
		var spawn_position = Vector2(spawn_x_position, 1)  # Enemies always spawn at Y = 1
		var new_enemy = Enemy_1.instantiate()
		add_child(new_enemy)
		new_enemy.global_position = spawn_position
		enemies_spawned.append(new_enemy)

	# Randomize the spawn timer for the next spawn
	spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	spawn_timer.start()

# This function is called every frame to update the game state
func _process(_delta):
	if game_data.game_over:  # Stop enemy movement when the game is over
		return

	var camera_position = camera_2d.global_position
	for enemy in enemies_spawned:
		# Move the enemy to the left
		enemy.global_position.x -= enemy_speed * _delta
		
		# Optionally remove enemies if they get too far behind the camera
		if enemy.global_position.x < camera_position.x - spawn_distance * 2:
			enemies_spawned.erase(enemy)
			enemy.queue_free()

extends Node

const Enemy_1 = preload("res://scenes/enemy.tscn")
@onready var spawn_timer: Timer = $SpawnTimer
@onready var camera_2d: Camera2D = $"../Player/Camera2D"

# The distance at which enemies will be spawned ahead of the camera
var spawn_distance: float = 500.0
var enemies_spawned: Array = []
var enemy_speed: float = 100.0 # Speed at which the enemies will move to the left
var min_spacing: float = 200.0 # Minimum distance between enemies
var max_spacing: float = 600.0 # Maximum distance between enemies
var min_spawn_time: float = 1.0 # Minimum wait time between spawns (in seconds)
var max_spawn_time: float = 3.0 # Maximum wait time between spawns (in seconds)

func _ready():
	# Seed the random number generator
	randomize()
	
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.wait_time = 1.0 # Initial spawn time, but will randomize after first spawn
	spawn_timer.start()

# This function is called whenever the spawn timer times out
func _on_spawn_timer_timeout():
	var camera_position = camera_2d.global_position
	
	# Generate random spacing between enemies
	var random_spacing = randi_range(min_spacing, max_spacing)
	var spawn_position = Vector2(camera_position.x + spawn_distance + random_spacing, camera_position.y)
	
	# Create an instance of the enemy scene and add it to the current scene
	var new_enemy = Enemy_1.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = spawn_position
	
	# Keep track of enemies spawned
	enemies_spawned.append(new_enemy)
	
	# Randomize the spawn timer for the next enemy
	spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	spawn_timer.start() # Restart the timer to apply the new wait time

# This function is called every frame to update the game state
func _process(_delta):
	var camera_position = camera_2d.global_position
	for enemy in enemies_spawned:
		# Move the enemy to the left
		enemy.global_position.x -= enemy_speed * _delta
		
		# Optionally remove enemies if they get too far behind the camera
		if enemy.global_position.x < camera_position.x - spawn_distance * 2:
			enemies_spawned.erase(enemy)
			enemy.queue_free()

extends Node

const Enemy_1 = preload("res://scenes/enemy.tscn")
@onready var spawn_timer: Timer = $SpawnTimer
@onready var camera_2d: Camera2D = $"../Player/Camera2D"

# The distance at which enemies will be spawned ahead of the camera
var spawn_distance: float = 500.0
var enemies_spawned: Array = []

func _ready():
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.wait_time = 1.0 # Set the wait time to control spawning frequency
	spawn_timer.start()

# This function is called whenever the spawn timer times out
func _on_spawn_timer_timeout():
	var camera_position = camera_2d.global_position
	var spawn_position = Vector2(camera_position.x + spawn_distance, camera_position.y)
	
	# Create an instance of the enemy scene and add it to the current scene
	var new_enemy = Enemy_1.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = spawn_position
	
	# Keep track of enemies spawned
	enemies_spawned.append(new_enemy)

# Optionally remove enemies if they get too far behind the camera
func _process(_delta):
	var camera_position = camera_2d.global_position
	for enemy in enemies_spawned:
		if enemy.global_position.x < camera_position.x - spawn_distance * 2:
			enemies_spawned.erase(enemy)
			enemy.queue_free()

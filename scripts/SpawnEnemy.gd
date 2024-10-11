extends Node

# Preload the enemy scene
const ENEMY_SCENE = preload("res://scenes/enemy.tscn")
@onready var camera_2d: Camera2D = $"../Player/Camera2D"
# Setup the timer
@onready var spawn_enemy_timer: Timer = $SpawnEnemyTimer

func _ready():
	# Connect the timeout signal to the spawn_enemy function
	spawn_enemy_timer.connect("timeout", self, "_spawn_enemy")

func _spawn_enemy():
	# Spawn the enemy scene at a random position within the camera's view
	var enemy_instance = ENEMY_SCENE.instance()
	enemy_instance.position = camera_2d.get_viewport_rect().size * Vector2(randf(), randf())
	add_child(enemy_instance)

func _process(delta):
	# Start the timer at a random time interval
	if not spawn_enemy_timer.is_stopped():
		return
	spawn_enemy_timer.start(rand_range(5, 15))  # adjust the time interval

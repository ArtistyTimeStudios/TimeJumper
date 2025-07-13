extends Node2D

# Preload all chunk scenes
const CHUNKS = [
	preload("res://scenes/chunk_gen1.tscn"),
	preload("res://scenes/chunk_gen2.tscn"),
	preload("res://scenes/chunk_gen3.tscn"),
	preload("res://scenes/chunk_gen4.tscn"),
	preload("res://scenes/chunk_gen5.tscn"),
	preload("res://scenes/chunk_gen6.tscn")
]

@onready var spawn_timer: Timer = $"../Spawner/SpawnTimer"

# Exported variables
@export var chunk_length: int = 16 # Length of each chunk in tiles
@export var generation_threshold: int = 2 # Number of chunks ahead of the player to generate

@onready var player: CharacterBody2D = $"../Player"

var last_generated_chunk = 0 # Keeps track of the last generated chunk index

func _ready():
	randomize() # Ensure different random results each time the game runs
	generate_chunk(0) # Generate the initial chunk

func _process(_delta):
	var current_chunk_index = int(player.position.x / (chunk_length * 16))

	if current_chunk_index + generation_threshold > last_generated_chunk:
		generate_chunk(last_generated_chunk + 1)

func generate_chunk(chunk_index):
	# Pick a random chunk scene from the list
	var selected_chunk = CHUNKS[randi() % CHUNKS.size()]
	var new_chunk = selected_chunk.instantiate()
	new_chunk.position = Vector2(chunk_index * chunk_length * 16, 0)
	add_child(new_chunk)
	last_generated_chunk = chunk_index

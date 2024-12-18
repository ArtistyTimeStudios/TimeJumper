extends Node2D

# Path to the chunk scene
const CHUNK_GEN_1 = preload("res://scenes/chunk_background1.tscn")
@onready var spawn_timer: Timer = $"../Spawner/SpawnTimer"

# Exported variables
@export var chunk_length: int = 14 # Length of each chunk in tiles
@export var generation_threshold: int = 2 # Number of chunks ahead of the player to generate

@onready var player: CharacterBody2D = $"../Player" # Correct usage of 'onready'

var last_generated_chunk = 0 # Keeps track of the last generated chunk index

func _ready():
	randomize() # Ensure different random results each time the game runs
	# Generate initial chunks
	generate_chunk(0)

func _process(_delta):
	# Determine which chunk the player is currently in
	var current_chunk_index = int(player.position.x / (chunk_length * 14))

	# Generate new chunks as the player progresses
	if current_chunk_index + generation_threshold > last_generated_chunk:
		generate_chunk(last_generated_chunk + 1)

func generate_chunk(chunk_index):
	# Always use CHUNK_GEN_1
	var selected_chunk = CHUNK_GEN_1

	# Create a new instance of the selected chunk scene
	var new_chunk = selected_chunk.instantiate()

	# Position the new chunk based on its index
	new_chunk.position = Vector2(chunk_index * chunk_length * 14, 0)

	# Add the new chunk to the ChunkGenerator node
	add_child(new_chunk)

	# Update the last generated chunk index
	last_generated_chunk = chunk_index

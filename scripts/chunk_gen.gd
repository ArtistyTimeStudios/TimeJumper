extends Node2D

# Path to the chunk scene
const CHUNK_GEN = preload("res://scenes/chunk_gen.tscn")

# Exported variables
@export var chunk_length: int = 16 # Length of each chunk in tiles
@export var generation_threshold: int = 2 # Number of chunks ahead of the player to generate

@onready var player: CharacterBody2D = $"../Player" # Use 'onready' without '@'

var last_generated_chunk = 0 # Keeps track of the last generated chunk index

func _ready():
	# Generate initial chunks
	generate_chunk(0)

func _process(delta):
	# Determine which chunk the player is currently in
	var current_chunk_index = int(player.position.x / (chunk_length * 16))

	# Generate new chunks as the player progresses
	if current_chunk_index + generation_threshold > last_generated_chunk:
		generate_chunk(last_generated_chunk + 1)

func generate_chunk(chunk_index):
	# Create a new instance of the chunk scene
	if CHUNK_GEN == null:
		print("CHUNK_GEN is not assigned.")
		return

	var new_chunk = CHUNK_GEN.instantiate()

	# Position the new chunk based on its index
	new_chunk.position = Vector2(chunk_index * chunk_length * 16, 0)

	# Add the new chunk to the ChunkGenerator node
	add_child(new_chunk)

	# Update the last generated chunk index
	last_generated_chunk = chunk_index

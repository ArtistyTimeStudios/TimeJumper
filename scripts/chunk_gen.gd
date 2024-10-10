extends Node2D

@onready var tile_map1: TileMap = $TileMap1
@onready var player: CharacterBody2D = $"../Player"

var tile_size = 16  # Assuming your tile size is 16x16
var map_size = 16  # Assuming your premade map is 16x16
var chunk_size = 4  # You can adjust this to control how many tiles are generated at a time
var chunk_cache = {}  # A dictionary to store generated chunks

func _ready():
	# Initialize the map with your premade tilemap
	for x in range(map_size):
		for y in range(map_size):
			tile_map1.set_cell(x, y, tile_map1.get_cell(map_size - 1 - x, map_size - 1 - y))

func _process(delta):
	# Check if the player is near the edge of the map
	var player_pos = player.global_position
	var player_chunk_x = floor(player_pos.x / (tile_size * chunk_size))
	var player_chunk_y = floor(player_pos.y / (tile_size * chunk_size))

	# Generate new chunks as needed
	generate_chunk(player_chunk_x, player_chunk_y)

	# Remove chunks that are far away from the player
	var chunk_distance = 3  # Adjust this to control how many chunks are kept around
	for chunk_key in chunk_cache.keys():
		var chunk_x = chunk_key[0]
		var chunk_y = chunk_key[1]
		if abs(chunk_x - player_chunk_x) > chunk_distance or abs(chunk_y - player_chunk_y) > chunk_distance:
			tile_map1.clear_cells(chunk_x * chunk_size, chunk_y * chunk_size, chunk_size, chunk_size)
			chunk_cache.erase(chunk_key)

func generate_chunk(chunk_x, chunk_y):
	# Check if the chunk has already been generated
	if chunk_cache.has(Vector2(chunk_x, chunk_y)):
		return

	# Calculate the top-left corner of the chunk
	var chunk_origin_x = chunk_x * chunk_size * tile_size
	var chunk_origin_y = chunk_y * chunk_size * tile_size

	# Generate tiles for the chunk
	for x in range(chunk_size):
		for y in range(chunk_size):
			var tile_x = chunk_origin_x + x * tile_size
			var tile_y = chunk_origin_y + y * tile_size

			# You can add your own logic here to determine which tile to place
			# For now, let's just place a random tile (replace 0 with your tile ID)
			tile_map1.set_cell(tile_x / tile_size, tile_y / tile_size, Vector2(0, 0))

	# Add the chunk to the cache
	chunk_cache[Vector2(chunk_x, chunk_y)] = true

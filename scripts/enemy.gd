extends Node2D  # or KinematicBody2D if you're using physics

# Speed of the enemy
var speed: int = 20  # Speed of the movement

# Reference to the AnimatedSprite2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Reference to the enemy scene (ensure this path is correct)
@export var enemy_scene: PackedScene  # Drag your enemy scene here in the editor

# Reference to the hero node (ensure this is correct)
@onready var player: CharacterBody2D = $"."


# Timer to spawn new enemies
@onready var timer: Timer = $Timer


func _ready() -> void:
	animated_sprite.play("Walk")  # Start the walking animation



func _process(delta: float) -> void:
	# Move the enemy to the left
	position.x -= speed * delta  # Move the enemy left

	# Check for screen boundaries
	if position.x < 0:  # If the enemy goes off the left edge
		position.x = get_viewport().size.x  # Reset to the right side  

# Function to handle enemy spawning
func _on_Timer_timeout() -> void:
	print("Spawning new enemies ahead of the hero")  # Debug message

	# Calculate spawn positions ahead of the hero
	var spawn_distance = 100  # Adjust this value to control how far ahead to spawn
	var initial_spawn_x = player.position.x + spawn_distance  # Starting x position for the first enemy
	var initial_spawn_y = player.position.y  # Match the hero's y position

	# Spawn 3 enemies ahead of the hero
	for i in range(3):
		var new_enemy = enemy_scene.instantiate()
		
		# Set the new enemy's position
		new_enemy.position = Vector2(initial_spawn_x + (i * 50), initial_spawn_y)  # Adjust the offset as needed

		# Add the new enemy to the scene
		get_parent().add_child(new_enemy)  # Add it to the same parent as this enemy

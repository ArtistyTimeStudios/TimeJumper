extends Area2D

@onready var timer: Timer = $Timer
@onready var player: Node = get_node("/root/Game/Player/")
@onready var game_data: Node = get_node("/root/Game/GameData")  # Assuming GameData manages the game state

func _on_body_entered(body: Node2D) -> void:
	print("umar")  # Print message for debugging
	Engine.time_scale = 0.4  # Slow down the game
	player.die()

	# Check if the body is the player
	if body.is_in_group("player"):  # Assuming the player is in the "player" group
		# Handle KinematicBody2D or RigidBody2D behaviors
		if body is AnimatedSprite2D:
			body.velocity = Vector2(0, -400)  # Set upward velocity for the jump
		elif body is RigidBody2D:
			body.linear_velocity = Vector2(body.linear_velocity.x, -1000)  # Directly set downward velocity

		# Optionally, remove the collision shape to prevent further collisions
		var collision_shape = body.get_node("CollisionShape2D")
		if collision_shape:
			collision_shape.queue_free()

	timer.start()

# Timer timeout function
func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0  # Restore normal game speed
	game_data.game_over = true  # Set game_over to true in game_data

	# Show a message or UI to the player indicating the game is over and to press a key to restart
	print("Game over! Press any key or click to restart.")

# Capture input to restart the game after the game is over
func _input(event: InputEvent) -> void:
	if game_data.game_over and (event is InputEventMouseButton or event is InputEventKey):
		get_tree().reload_current_scene()  # Reload the current scene on user input

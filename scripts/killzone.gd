extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("umar")  # Print message for debugging
	Engine.time_scale = 0.0  # Slow down the game
	
	# Check if the body is the player
	if body.is_in_group("player"):  # Assuming the player is in the "player" group
		# Assuming body is a KinematicBody2D
		if body is AnimatedSprite2D:
			body.velocity = Vector2(0, -400)  # Set upward velocity for the jump (adjust as necessary)
			body.apply_impulse(Vector2(0, 0), Vector2(0, -1000))  # Optional, apply an impulse for jumping

		elif body is RigidBody2D:
			body.linear_velocity = Vector2(body.linear_velocity.x, -1000)  # Directly set downward velocity for RigidBody

		# Optionally, remove the collision shape to prevent further collisions
		var collision_shape = body.get_node("CollisionShape2D")  # Change as necessary
		if collision_shape:
			collision_shape.queue_free()

	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0  # Restore normal game speed
	get_tree().reload_current_scene()  # Reload the scene

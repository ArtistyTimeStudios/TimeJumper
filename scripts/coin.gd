extends Area2D

# Node references
@onready var coin_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var plus_100_sprite: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D


@onready var game_data: Node = get_node("/root/Game/GameData")

# This function is triggered when any body enters the Area2D's collision shape
func _on_body_entered(_body: Node2D):
	print("Coin script ")
	game_data.add_point()  # Call add_point on the game data node
	coin_sprite.visible = false  # Immediately make the coin invisible
	coin_sprite.queue_free()  # Remove the coin (AnimatedSprite2D) from the scene
	plus_100_sprite.visible = true  # Make the +100 AnimatedSprite visible
	#plus_100_sprite.play("show")  # Play the animation for +100
	await get_tree().create_timer(2.0).timeout  # Wait for 2 seconds
	plus_100_sprite.visible = false  # Make the +100 AnimatedSprite invisible again

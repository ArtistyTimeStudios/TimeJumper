extends Area2D

# Node references
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_data: Node = get_node("/root/Game/GameData")

# This function is triggered when any body enters the Area2D's collision shape
func _on_body_entered(_body: Node2D):
	print("Coin script ")
	game_data.add_point()  # Call add_point on the game data node
	#print("Coin collected")
	#animation_player.play("pickup")  # Play pickup animation
	queue_free()  # Remove the coin

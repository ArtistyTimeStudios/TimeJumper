extends Node

# Preload the enemy scene
@onready var enemy = preload("res://scenes/enemy.tscn")


func _on_timer_timeout() -> void:
	# Instantiate the enemy scene
	var ene = enemy.instantiate()
	# Set the enemy's position to the current node's position
	ene.position = position
	# Add the enemy to the parent node
	get_parent().get.node("Enemy").add_child(ene)

extends Area2D

var score = 0

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer
@onready var coin_counter: Label = $"../CoinCOUNTER"

func _on_body_entered(body):
	game_manager.add_point()
	queue_free()

func add_point():
	score += 1
	score_label.text = "Score" + str(score) + " coins."


#func _on_body_entered(body):
#	game_manager.add_point()
#	animation_player.play("pickup")

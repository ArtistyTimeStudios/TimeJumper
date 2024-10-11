extends Node
#@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var score_label: Control = $"../Player/Camera2D/UI/MarginContainer/VBoxContainer/ScoreLabel"

var score = 0
#@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel
#@onready var coin = $"."
#coin counbter
func add_point():
	print("Coin collected")
	score += 1
	score_label.text ="Coins: " + str(score)

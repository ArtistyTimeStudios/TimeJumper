extends Node

@onready var score_label: Control = $"../Player/Camera2D/UI/MarginContainer/VBoxContainer/ScoreLabel"
@onready var player: CharacterBody2D = $"../Player"

var score = 0
var time_passed = 0.0  # Keeps track of the elapsed time
var game_over = false  # Variable to track if the game is over

# Called when the node is added to the scene
func _ready():
	update_score_label()

# Function to add 100 meters when a coin is collected
func add_point():
	if not game_over:  # Only add points if the game is not over
		print("Coin collected")
		score += 100  # Add 100 to the current score
		update_score_label()

# Called every frame
func _process(delta):
	if not game_over:  # Only update the score if the game is not over
		# Increment the elapsed time by the frame time (delta)
		time_passed += delta

		# Check if 0.5 seconds have passed
		if time_passed >= 0.5:
			score += 1  # Add 1 meter to the score
			update_score_label()
			time_passed = 0.0  # Reset the time tracker

# Helper function to update the score label with the current score
func update_score_label():
	score_label.text = " SCORE
	 " + str(score)

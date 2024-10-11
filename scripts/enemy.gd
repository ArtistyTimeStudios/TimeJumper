extends Node2D

@export var speed: float = 50.0 # Speed at which the enemy moves to the left
@export var pop_up_time_min: float = 2.0 # Minimum time before the enemy pops up
@export var pop_up_time_max: float = 5.0 # Maximum time before the enemy pops up

var moving = false

@onready var sprite: Sprite2D = $"Sprite2D"
@onready var timer: Timer = $"Timer"

func _ready():
	# Set the timer to a random time between the min and max
	timer.wait_time = randf_range(pop_up_time_min, pop_up_time_max)
	timer.one_shot = true
	timer.start()
	# Hide the enemy initially
	sprite.visible = false

func _process(delta):
	if moving:
		# Move to the left
		position.x -= speed * delta
		# Destroy the enemy if it goes off-screen
		if position.x < -100:
			queue_free()

func _on_Timer_timeout():
	# Make the enemy appear and start moving
	sprite.visible = true
	moving = true

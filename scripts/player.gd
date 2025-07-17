extends CharacterBody2D

const BASE_SPEED = 60.0
const JUMP_VELOCITY = -300.0
var is_jumping = false  # Track if the character is jumping
var is_alive = true  # Manage if the player is alive
var current_speed = BASE_SPEED  # This will be adjusted when points increase
var last_score_checkpoint = 0  # Track when the speed was last increased

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_data: Node = get_node("/root/Game/GameData")  # Reference to GameData for score
@onready var jump: AudioStreamPlayer = $jump
@onready var run: AudioStreamPlayer = $run
@onready var died: AudioStreamPlayer = $died

func _ready():
	sound_manager.play_game_music()


func _physics_process(delta: float) -> void:
	if is_alive:
		# Add gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			if is_jumping:
				is_jumping = false  # Reset jumping flag when back on the floor
				animated_sprite.play("walk")  # Play walk animation when on the floor and not jumping
		# Handle jump with screen touch.
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_on_floor():
			jump.play()
			animated_sprite.play("jump")
			velocity.y = JUMP_VELOCITY
			is_jumping = true  # Play jump animation when jumping
		# Increase speed based on score.
		check_speed_increase()
		# Move to the right all the time, with updated speed.
		velocity.x = current_speed
		# Apply movement and handle animations.
		move_and_slide()
	else:
		velocity = Vector2.ZERO  # Stop all movement
		move_and_slide()  # This will ensure any remaining motion is halted
		

# Function to handle death
func die():
	died.play()
	is_alive = false
	animated_sprite.play("death")

# Function to check if the player should speed up based on score
func check_speed_increase():
	# Access the current score from the GameData node (assumes GameData has a 'score' variable)
	var current_score = game_data.score
	# Check if the score has increased by 200 points since the last speed increase
	if current_score >= last_score_checkpoint + 200:
		current_speed += 10.0  # Increase speed by 20 (or adjust this value as needed)
		last_score_checkpoint = current_score  # Update the checkpoint to the current score

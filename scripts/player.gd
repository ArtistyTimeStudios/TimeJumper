extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -300.0
const LEFT_MOUSE_BUTTON = 1  # Left mouse button is represented by the integer value 1
var is_jumping = false  # Track if the character is jumping



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump with screen touch.
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(LEFT_MOUSE_BUTTON)) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true  # Set jumping flag to true

	# Move to the right all the time.
	velocity.x = SPEED

	move_and_slide()

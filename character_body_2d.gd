extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const LEFT_MOUSE_BUTTON = 1  # Left mouse button is represented by the integer value 1
const ROTATION_SPEED = 5.0  # Rotation speed
const JUMP_ROTATION = -0.2  # Angle to rotate slightly left on jump
var is_jumping = false  # Track if the character is jumping

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump with screen touch.
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(LEFT_MOUSE_BUTTON)) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		rotation += JUMP_ROTATION  # Rotate slightly left on jump
		is_jumping = true  # Set jumping flag to true

	# Reset rotation after jump
	if is_jumping and is_on_floor():
		is_jumping = false  # Reset jump flag when landing

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

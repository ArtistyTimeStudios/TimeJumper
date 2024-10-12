extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -300.0

var is_jumping = false  # Track if the character is jumping
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if is_jumping:
			is_jumping = false  # Reset jumping flag when back on the floor
			animated_sprite.play("walk")  # Play run animation when on the floor and not jumping

	# Handle jump with screen touch.
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_on_floor():
		animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY
		is_jumping = true
  # Play jump animation when jumping

	# Move to the right all the time.
	velocity.x = SPEED

	# Apply movement and handle animations.
	move_and_slide()

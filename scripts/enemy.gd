extends CharacterBody2D

# Gravity strength (pixels per second squared)
const GRAVITY = 980.0

func _physics_process(delta: float) -> void:
	# Apply gravity if the character is not on the floor
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		# Reset vertical velocity when on the floor
		velocity.y = 0

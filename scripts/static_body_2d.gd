extends StaticBody2D


var speed = 100  # Adjust this value to control the speed
var direction = -1  # -1 for left, 1 for right

func _physics_process(delta):
	position.x += speed * direction * delta
	if position.x < 0 or position.x > get_viewport().get_size().x:
		direction *= -1  # Reverse direction

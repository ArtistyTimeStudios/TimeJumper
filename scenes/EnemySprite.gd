extends AnimatedSprite2D

func _ready() -> void:
	randomize()
	
	var hue = randf()                     # Full color wheel
	var saturation = 1.0                  # Full color intensity
	var value = 1.0                       # Maximum brightness

	modulate = Color.from_hsv(hue, saturation, value, 1.0)

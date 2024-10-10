extends Label

var speed: float = 100  # Prędkość przesuwania etykiety (można usunąć, jeśli nie jest używana)
@onready var camera_2d: Camera2D = get_node("../../Player/Camera2D")  # Poprawna ścieżka do kamery

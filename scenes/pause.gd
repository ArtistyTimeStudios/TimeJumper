extends Button

func _ready() -> void:
	# Podpinamy kliknięcie przycisku do funkcji
	pressed.connect(_on_pause_pressed)

func _on_pause_pressed() -> void:
	# Wraca do menu głównego
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

extends Control

func _ready() -> void:
	# Na wszelki wypadek odznacz pauzę, gdy wrócisz z gry
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("UI_CANCEL PRESSED")
		get_tree().quit()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

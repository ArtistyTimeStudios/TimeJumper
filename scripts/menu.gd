extends Control

func _ready() -> void:
	get_tree().paused = false
	sound_manager.stop_all_music()
	sound_manager.play_menu_music()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

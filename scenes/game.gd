extends Node2D  # lub Control, zależnie od typu głównego noda

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		print("UI_CANCEL detected, going back to menu.")
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

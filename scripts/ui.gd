extends Control

@onready var menu_button = $MarginContainer/VBoxContainer/Menu

func _ready() -> void:
	# Tylko jeśli sygnał NIE jest już podpięty w edytorze:
	# menu_button.pressed.connect(_on_menu_pressed)
	pass  # <-- nie rób nic więcej jeśli podpięte ręcznie

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

extends Control

@onready var music_button = $MarginContainer/VBoxContainer/Music
@onready var volume_label = $MarginContainer/VBoxContainer/HBoxContainer/Volume
@onready var volume_down_btn = $MarginContainer/VBoxContainer/HBoxContainer/Minus
@onready var volume_up_btn = $MarginContainer/VBoxContainer/HBoxContainer/Plus
@onready var back_button = $MarginContainer/VBoxContainer/Back

var current_volume := 50
var music_on := true

func _ready():
	update_volume_display()
	update_music_button_text()

	volume_down_btn.pressed.connect(_on_volume_down)
	volume_up_btn.pressed.connect(_on_volume_up)
	music_button.pressed.connect(_on_music_toggle)
	back_button.pressed.connect(_on_back)

func update_volume_display():
	volume_label.text = str(current_volume)

func update_music_button_text():
	if music_on:
		music_button.text = "Music: ON"
	else:
		music_button.text = "Music: OFF"

func _on_volume_down():
	current_volume = max(0, current_volume - 10)
	update_volume_display()

func _on_volume_up():
	current_volume = min(100, current_volume + 10)
	update_volume_display()

func _on_music_toggle():
	music_on = !music_on
	update_music_button_text()

func _on_back():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

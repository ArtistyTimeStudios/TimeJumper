extends Node

@onready var bcmusic: AudioStreamPlayer = $BCmusic
@onready var menumusic: AudioStreamPlayer = $menuMusic

func _ready() -> void:
	await get_tree().process_frame  # poczekaj aż załaduje się scena
	_handle_scene_change()

func _notification(what):
	if what == NOTIFICATION_ENTER_TREE:
		call_deferred("_handle_scene_change")

func _handle_scene_change():
	await get_tree().process_frame  # Poczekaj na aktualną scenę
	var scene = get_tree().current_scene
	if scene == null:
		return
	
	match scene.name:
		"menu":
			play_menu_music()
		"game":
			play_game_music()
		_:
			stop_all_music()

# -----------------------------
# 🎮 Muzyka do gry (hardbass)
# -----------------------------
func play_game_music():
	if menumusic.playing:
		menumusic.stop()
	if not bcmusic.playing:
		bcmusic.play()

# -----------------------------
# 🏠 Muzyka menu
# -----------------------------
func play_menu_music():
	if bcmusic.playing:
		bcmusic.stop()
	if not menumusic.playing:
		menumusic.play()

# -----------------------------
# 🛑 Zatrzymaj wszystko
# -----------------------------
func stop_all_music():
	bcmusic.stop()
	menumusic.stop()

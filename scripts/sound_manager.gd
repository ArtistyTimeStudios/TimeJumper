extends Node
@onready var bcmusic: AudioStreamPlayer = $BCmusic
@onready var player: CharacterBody2D = $"../Player"

# Play background music
func play_music():
	if not bcmusic.playing:
		bcmusic.play()

# Stop background music
func stop_music():
	bcmusic.stop()

extends Node
@onready var player: Node = get_node("/root/Game/Player/")
@onready var bcmusic: AudioStreamPlayer = $BCmusic

func _on_Player_died():
	bcmusic.stop()  # Stop the music when the player dies

func _on_Player_alive():
	bcmusic.play()  # Play the music when the player is alive

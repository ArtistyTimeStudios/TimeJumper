extends Node

# Preload prefabów
const COIN = preload("res://scenes/coin.tscn")
const Enemy_1 = preload("res://scenes/enemy.tscn")

# Odwołania do node’ów ze sceny
@onready var spawn_timer: Timer = $SpawnTimer
@onready var camera_2d: Camera2D = $"../Player/Camera2D"
@onready var game_data: Node = get_node("/root/Game/GameData")  # Stan gry: np. czy jest game over

# Parametry spawnowania
var spawn_distance: float = 500.0  # Jak daleko przed kamerą pojawiają się obiekty
var enemies_spawned: Array = []  # Lista aktywnych wrogów
var enemy_speed: float = 50.0  # Prędkość, z jaką wróg porusza się w lewo

# Czas pomiędzy spawnami
var min_spawn_time: float = 1.0
var max_spawn_time: float = 5.0

# Kontrola minimalnej odległości między kolejnymi wrogami
var last_enemy_x_position: float = -9999.0  # Pozycja X ostatniego wroga
var enemy_min_distance: float = 250.0  # Minimalna odległość X między kolejnymi wrogami

func _ready():
	# Losowanie startowe i uruchomienie timera
	randomize()
	spawn_timer.wait_time = 0.1
	spawn_timer.start()

# Funkcja wywoływana co zakończenie timera
func _on_spawn_timer_timeout():
	# Nie spawnuj jeśli gra się skończyła
	if game_data.game_over:
		return

	# Ustal pozycję kamery i losowy odstęp od niej
	var camera_position = camera_2d.global_position
	var random_spacing = randi_range(200, 600)
	var spawn_x_position = camera_position.x + spawn_distance + random_spacing

	# 20% szansy na spawn monety
	if randf() < 0.2:
		var ground_y_position = 1  # Poziom gruntu
		var offset_above_ground = randf_range(0, 60)  # Wysokość nad ziemią
		var random_y_position = ground_y_position - offset_above_ground
		var spawn_position = Vector2(spawn_x_position, random_y_position)

		var new_coin = COIN.instantiate()
		add_child(new_coin)
		new_coin.global_position = spawn_position
	else:
		# Sprawdź, czy nowy wróg nie jest zbyt blisko poprzedniego
		if abs(spawn_x_position - last_enemy_x_position) < enemy_min_distance:
			# Jeśli tak — poczekaj chwilę i nie spawnuj niczego
			spawn_timer.wait_time = 0.2
			spawn_timer.start()
			return

		# Spawn wroga
		var spawn_position = Vector2(spawn_x_position, 1)  # Na poziomie ziemi
		var new_enemy = Enemy_1.instantiate()
		add_child(new_enemy)
		new_enemy.global_position = spawn_position

		# Zapamiętaj wroga i jego pozycję
		enemies_spawned.append(new_enemy)
		last_enemy_x_position = spawn_x_position

	# Losowy czas do kolejnego spawnu (jeśli nie było pominięcia)
	spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	spawn_timer.start()

# Funkcja wywoływana co klatkę
func _process(_delta):
	# Nie przesuwaj wrogów jeśli gra się skończyła
	if game_data.game_over:
		return

	var camera_position = camera_2d.global_position

	# Przesuwaj wszystkich wrogów w lewo
	for enemy in enemies_spawned:
		enemy.global_position.x -= enemy_speed * _delta

		# Usuń wroga, jeśli jest zbyt daleko za kamerą (czyli niewidoczny)
		if enemy.global_position.x < camera_position.x - spawn_distance * 2:
			enemies_spawned.erase(enemy)
			enemy.queue_free()

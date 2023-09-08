extends Node2D

# Variables
var is_game_over = false
var is_game_paused = false
var score = 0
var tetromino_scene = preload("res://scenes/Tetromino.tscn")
var current_tetromino
var drop_timer = 0
var drop_interval = 1.0  # Tiempo en segundos para que el Tetromino caiga una fila

# Función que se ejecuta al inicio
func _ready():
	start_game()

# Iniciar el juego
func start_game():
	is_game_over = false
	is_game_paused = false
	score = 0
	call_deferred("spawn_tetromino")


# Función que se ejecuta cada frame
func _process(delta):
	if is_game_paused or is_game_over:
		return

	drop_timer += delta
	if drop_timer > drop_interval:
		drop_timer = 0
		move_tetromino(0, 1)

# Mover el Tetromino y verificar colisiones con la cuadrícula
func move_tetromino(delta_x, delta_y):
	current_tetromino.move(delta_x, delta_y)
	# Aquí puedes añadir lógica para verificar colisiones con la cuadrícula y ajustar la posición si es necesario

# Pausar el juego
func pause_game():
	if is_game_paused:
		is_game_paused = false
		# Reanudar la lógica del juego
	else:
		is_game_paused = true
		# Pausar la lógica del juego

# Finalizar el juego
func game_over():
	is_game_over = true
	# Mostrar pantalla de fin de juego, puntuación, etc.

# Actualizar puntuación
func update_score(points):
	score += points
	# Actualizar la interfaz de usuario con la nueva puntuación

# Instanciar un nuevo Tetromino
func spawn_tetromino():
	current_tetromino = tetromino_scene.instantiate()
	add_child(current_tetromino)

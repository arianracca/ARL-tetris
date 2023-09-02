extends Node2D

# Variables
var is_game_over = false
var is_game_paused = false
var score = 0

# Función que se ejecuta al inicio
func _ready():
	start_game()

# Iniciar el juego
func start_game():
	is_game_over = false
	is_game_paused = false
	score = 0
	# Aquí puedes añadir lógica para inicializar la cuadrícula, Tetrominos, etc.

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

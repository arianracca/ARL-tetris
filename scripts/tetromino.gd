extends Node2D

# Variables
# Variables
var tetromino_scenes = [
	preload("res://scenes/TetrominoI.tscn"),
	preload("res://scenes/TetrominoJ.tscn"),
	preload("res://scenes/TetrominoL.tscn"),
	preload("res://scenes/TetrominoO.tscn"),
	preload("res://scenes/TetrominoS.tscn"),
	preload("res://scenes/TetrominoT.tscn"),
	preload("res://scenes/TetrominoZ.tscn")
]

var current_tetromino_instance

# Función que se ejecuta al inicio
func _ready():
	randomize_tetromino()

# Seleccionar y cargar una escena de Tetromino aleatoria
func randomize_tetromino():
	var random_scene = tetromino_scenes[randi() % tetromino_scenes.size()]
	current_tetromino_instance = random_scene.instance()
	add_child(current_tetromino_instance)

# Mover el Tetromino
func move(delta_x, delta_y):
	current_tetromino_instance.position.x += delta_x
	current_tetromino_instance.position.y += delta_y
	# Verificar colisiones y ajustar la posición si es necesario

# Rotar el Tetromino
# Rotar el Tetromino
func rotate_tetromino():
	current_tetromino_instance.rotation_degrees += 90
	# Verificar colisiones y ajustar la rotación si es necesario

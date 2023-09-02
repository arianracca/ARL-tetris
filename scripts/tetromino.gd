extends Node2D

# Variables
var grid = preload("res://scenes/Grid.tscn")  # Asume que tienes un nodo Grid en la misma escena o ajusta la ruta según tu estructura

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
	position.x += delta_x * grid.block_size
	position.y += delta_y * grid.block_size
	
	# Verificar colisiones y ajustar la posición si es necesario
	if has_collision():
		position.x -= delta_x * grid.block_size
		position.y -= delta_y * grid.block_size



# Rotar el Tetromino
func rotate_tetromino():
	current_tetromino_instance.rotation_degrees += 90
	
	# Verificar colisiones y ajustar la rotación si es necesario
	if has_collision():
		rotation_degrees -= 90


func has_collision() -> bool:
	# Aquí, asumimos que cada Tetromino tiene hijos que representan cada bloque individual.
	# Iteramos sobre cada bloque y verificamos si está fuera de los límites de la cuadrícula o si colisiona con un bloque ocupado.
	for block in get_children():
		var grid_x = int(block.global_position.x / grid.block_size)
		var grid_y = int(block.global_position.y / grid.block_size)
		
		# Verificar límites de la cuadrícula
		if grid_x < 0 or grid_x >= grid.grid_width or grid_y < 0 or grid_y >= grid.grid_height:
			return true
		
		# Verificar bloques ocupados en la cuadrícula
		if grid.is_cell_occupied(grid_x, grid_y):
			return true
	
	return false

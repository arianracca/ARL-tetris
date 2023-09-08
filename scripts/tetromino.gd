extends Node2D

# Variables
@export var grid_scene : PackedScene
@export var block_scene : PackedScene
var grid_instance


var tetromino_shapes = [
	# Tetromino I
	[
		[1, 1, 1, 1]
	],
	# Tetromino J
	[
		[0, 0, 1],
		[1, 1, 1]
	],
	# Tetromino L
	[
		[1, 0, 0],
		[1, 1, 1]
	],
	# Tetromino O
	[
		[1, 1],
		[1, 1]
	],
	# Tetromino S
	[
		[0, 1, 1],
		[1, 1, 0]
	],
	# Tetromino T
	[
		[0, 1, 0],
		[1, 1, 1]
	],
	# Tetromino Z
	[
		[1, 1, 0],
		[0, 1, 1]
	]
]

var current_tetromino = []


# Función que se ejecuta al inicio
func _ready():
	grid_instance = grid_scene.instantiate()
	grid_instance.connect("ready", self, "_on_Grid_ready")
	call_deferred("add_child", grid_instance)
	
	var block = block_scene.instantiate()
	add_child(block)
	randomize_tetromino()



# Seleccionar y cargar un Tetromino aleatorio
func randomize_tetromino():
	current_tetromino = tetromino_shapes[randi() % tetromino_shapes.size()]
	draw_tetromino()


func draw_tetromino():
	for i in range(len(current_tetromino)):
		for j in range(len(current_tetromino[i])):
			if current_tetromino[i][j] == 1:
				var block = block_scene.instantiate()
				block.position = Vector2(j * grid_instance.block_size, i * grid_instance.block_size)
				add_child(block)


# Mover el Tetromino
func move(delta_x, delta_y):
	position.x += delta_x * grid_instance.block_size
	position.y += delta_y * grid_instance.block_size
	# Verificar colisiones y ajustar la posición si es necesario
	if has_collision():
		position.x -= delta_x * grid_instance.block_size
		position.y -= delta_y * grid_instance.block_size


# Rotar el Tetromino
func rotate_tetromino():
	var center = get_center()
	for block in get_children():
		var relative_pos = block.position - center
		block.position = center + Vector2(relative_pos.y, -relative_pos.x)
	if has_collision():
		for block in get_children():
			var relative_pos = block.position - center
			block.position = center + Vector2(-relative_pos.y, relative_pos.x)


func get_center() -> Vector2:
	return Vector2(
(grid_instance.block_size * len(current_tetromino[0])) / 2,
(grid_instance.block_size * len(current_tetromino)) / 2
)


func has_collision() -> bool:
	# Aquí, asumimos que cada Tetromino tiene hijos que representan cada bloque individual.
	# Iteramos sobre cada bloque y verificamos si está fuera de los límites de la cuadrícula o si colisiona con un bloque ocupado.
	for block in get_children():
		var grid_x = int(block.global_position.x / grid_instance.block_size)
		var grid_y = int(block.global_position.y / grid_instance.block_size)
		
		# Verificar límites de la cuadrícula
		if grid_x < 0 or grid_x >= grid_instance.grid_width or grid_y < 0 or grid_y >= grid_instance.grid_height:
			return true
		
		# Verificar bloques ocupados en la cuadrícula
		if grid_instance.is_cell_occupied(grid_x, grid_y):
			return true
	
	return false

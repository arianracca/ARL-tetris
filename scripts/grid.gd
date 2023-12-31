extends Node2D

# Variables
var grid_width = 10
var grid_height = 20
var block_size = 32
var grid = []

# Función que se ejecuta al inicio
func _ready():
	initialize_grid()

# Inicializar la cuadrícula con valores vacíos
func initialize_grid():
	grid = []
	for x in range(grid_width):
		grid.append([])
		for y in range(grid_height):
			grid[x].append(null)

# Verificar si una posición en la cuadrícula está ocupada
func is_cell_occupied(x, y):
	if is_cell_within_bounds(x, y):
		return grid[x][y] != null
	return true

# Verificar si una posición en la cuadrícula está dentro de los límites
func is_cell_within_bounds(x, y):
	return x >= 0 and x < grid_width and y >= 0 and y < grid_height

# Añadir un bloque a una posición específica en la cuadrícula
func set_cell(x, y, value):
	if is_cell_within_bounds(x, y):
		grid[x][y] = value

# Obtener el color de un bloque en una posición específica
func get_cell_color(x, y):
	if is_cell_within_bounds(x, y):
		return grid[x][y]
	return null

# Verificar si una fila está completa
func is_row_complete(y):
	for x in range(grid_width):
		if grid[x][y] == null:
			return false
	return true

# Eliminar una fila y mover todas las filas superiores hacia abajo
func clear_row(y):
	for x in range(grid_width):
		grid[x][y] = null
	for row in range(y, 0, -1):
		for x in range(grid_width):
			grid[x][row] = grid[x][row - 1]
			grid[x][row - 1] = null

# Verificar y limpiar todas las filas completas
func check_and_clear_rows():
	var rows_cleared = 0
	for y in range(grid_height):
		if is_row_complete(y):
			clear_row(y)
			rows_cleared += 1
	return rows_cleared

# Dibuja la cuadrícula y los bloques
func _draw():
	for x in range(grid_width):
		for y in range(grid_height):
			if grid[x][y] != null:
				draw_rect(Rect2(x * block_size, y * block_size, block_size, block_size), grid[x][y])

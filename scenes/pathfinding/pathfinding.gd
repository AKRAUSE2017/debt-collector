extends Node2D

@export var cellSize = Vector2i(96, 96)

var grid = AStarGrid2D.new()
var start = Vector2(0,0)
var end = Vector2(384, 384)

func _ready():
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	initialize_grid()

func initialize_grid():
	var gridSize = Vector2i(get_viewport_rect().size) / cellSize
	grid.size = gridSize
	grid.cell_size = cellSize
	grid.offset = cellSize / 2 # calculate from the center
	grid.update()
	
	update_path()
	
func update_path():
	$Line2D.points = PackedVector2Array(grid.get_point_path(start, end))

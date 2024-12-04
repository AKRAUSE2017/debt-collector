extends Node2D

@onready var cellSize = Vector2(ProjectSettings.get_setting("CELL_SIZE"), ProjectSettings.get_setting("CELL_SIZE"))

var grid = AStarGrid2D.new()

var levelSize = Vector2(ProjectSettings.get_setting("LEVEL_WIDTH"), ProjectSettings.get_setting("LEVEL_HEIGHT"))

func _ready():
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	initialize_grid()

func initialize_grid():
	var gridSize = levelSize / cellSize
	grid.size = gridSize
	grid.cell_size = cellSize
	grid.offset = cellSize / 2 # calculate from the center
	grid.update()
	
func update_path(start, end):
	var path = PackedVector2Array(grid.get_point_path(start, end))
	$Line2D.points = path
	return path
	
func show_proposed_path(start, end):
	$Line2D.points = PackedVector2Array(grid.get_point_path(start, end))

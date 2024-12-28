extends Node2D

@onready var cellSize = Vector2(ProjectSettings.get_setting("CELL_SIZE"), ProjectSettings.get_setting("CELL_SIZE"))

var grid = AStarGrid2D.new()

var levelSize = Vector2(ProjectSettings.get_setting("LEVEL_WIDTH"), ProjectSettings.get_setting("LEVEL_HEIGHT"))

func _ready():
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	initialize_grid()

func initialize_grid():
	var gridSize = levelSize / cellSize
	grid.size = gridSize
	grid.cell_size = cellSize
	grid.offset = cellSize / 2 # calculate from the center
	grid.update()
	
# called by playerController once the obstacles are set
func add_obstacles(obstacles):
	for point in obstacles:
		var xy = floor(point / ProjectSettings.get_setting("CELL_SIZE"))
		grid.set_point_solid(xy)
	
func update_path(start, end):
	if(grid.is_in_boundsv(start) and grid.is_in_boundsv(end)):
		var path = PackedVector2Array(grid.get_point_path(start, end))
		$Line2D.points = path
		# print(path)
		return path
	
func show_proposed_path(start, end):
	if(grid.is_in_boundsv(start) and grid.is_in_boundsv(end)):
		$Line2D.points = PackedVector2Array(grid.get_point_path(start, end))

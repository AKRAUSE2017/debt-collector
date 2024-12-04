extends Node2D

@onready var GRIDSPACE:int = ProjectSettings.get_setting("CELL_SIZE")

func _process(_delta):
	var mouseCoords = get_global_mouse_position()
	# ceil(mouse/gridsize) * gridsize - gridsize/2
	self.position.x = ceil(mouseCoords.x/GRIDSPACE) * GRIDSPACE - (GRIDSPACE/2)
	self.position.y = ceil(mouseCoords.y/GRIDSPACE) * GRIDSPACE - (GRIDSPACE/2)

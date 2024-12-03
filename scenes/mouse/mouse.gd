extends Node2D

const GRIDSPACE:int = 96

func _process(delta):
	var mouseCoords = get_global_mouse_position()
	# ceil(mouse/gridsize) * gridsize - gridsize/2
	self.position.x = ceil(mouseCoords.x/GRIDSPACE) * GRIDSPACE - (GRIDSPACE/2)
	self.position.y = ceil(mouseCoords.y/GRIDSPACE) * GRIDSPACE - (GRIDSPACE/2)
	print(self.position.x, self.position.y)

extends Node2D

@export var obstacles: Array = []

func _process(_delta):
	if $PlayerBody.isFollowingPath: return
	var start = floor($PlayerBody.position / ProjectSettings.get_setting("CELL_SIZE"))
	var end = floor($Mouse.position / ProjectSettings.get_setting("CELL_SIZE"))
	$Pathfinding.show_proposed_path(start, end)

func _input(event):
	if (event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		if $PlayerBody.isFollowingPath: return
		var start = floor($PlayerBody.position / ProjectSettings.get_setting("CELL_SIZE"))
		var end = floor($Mouse.position / ProjectSettings.get_setting("CELL_SIZE"))
		var path = $Pathfinding.update_path(start, end)
		$PlayerBody.path = path

func update_grid_with_obstacles():
	$Pathfinding.add_obstacles(obstacles)

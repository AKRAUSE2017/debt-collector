extends Node2D

func _process(_delta):
	if $Player.isFollowingPath: return
	var start = floor($Player.position / ProjectSettings.get_setting("CELL_SIZE"))
	var end = floor($Mouse.position / ProjectSettings.get_setting("CELL_SIZE"))
	$Pathfinding.show_proposed_path(start, end)

func _input(event):
	if (event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		if $Player.isFollowingPath: return
		var start = floor($Player.position / ProjectSettings.get_setting("CELL_SIZE"))
		var end = floor($Mouse.position / ProjectSettings.get_setting("CELL_SIZE"))
		var path = $Pathfinding.update_path(start, end)
		$Player.path = path

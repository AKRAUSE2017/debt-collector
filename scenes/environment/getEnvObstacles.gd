extends Node

func _ready():
	var children = get_children()
	var parentLevel = get_parent()
	print("parent level", parentLevel.name, parentLevel.get_node("Player").name )
	var obstacles = []
	for child in children:
		if child.get_class() == "TileMap": continue
		obstacles.push_back(child.position)
	var playerController = parentLevel.get_node("Player") 
	if playerController: 
		print("setting obstacles", obstacles)
		playerController.obstacles = obstacles
		playerController.update_grid_with_obstacles()

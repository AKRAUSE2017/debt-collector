extends Camera2D

func _ready():
	self.limit_right = ProjectSettings.get_setting("LEVEL_WIDTH")
	self.limit_bottom = ProjectSettings.get_setting("LEVEL_HEIGHT")

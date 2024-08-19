extends Area2D

@onready var coneSprite:String = "res://assets/placeholders/vision_cone.png"
@onready var coneRedSprite:String = "res://assets/placeholders/vision_cone_red.png"

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", _on_area_2d_body_entered)
	self.connect("body_exited", _on_area_2d_body_excited)
	sprite.set_texture(load(coneSprite))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player": sprite.set_texture(load(coneRedSprite))

func _on_area_2d_body_excited(body):
	if body.name == "Player": sprite.set_texture(load(coneSprite))

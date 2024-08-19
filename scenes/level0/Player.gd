extends CharacterBody2D

const SPEED:int = 120
const GRIDSPACE:int = 64

var travel:Vector2 = Vector2.ZERO
var travelEnd:Vector2 = Vector2.ZERO

func _ready():
	self.position = Vector2(32, 32)

func _process(_delta):
	if travel == Vector2.ZERO:
		if Input.is_action_just_pressed("ui_right"):
			travel = Vector2(SPEED,0)
			travelEnd.x = int(self.position.x + GRIDSPACE)
		if Input.is_action_just_pressed("ui_left"):
			travel = Vector2(-SPEED,0)
			travelEnd.x = int(self.position.x - GRIDSPACE)
		if Input.is_action_just_pressed("ui_up"):
			travel = Vector2(0, -SPEED)
			travelEnd.y = int(self.position.y - GRIDSPACE)
		if Input.is_action_just_pressed("ui_down"):
			travel = Vector2(0, SPEED)
			travelEnd.y = int(self.position.y + GRIDSPACE)
		self.velocity = travel
		
	else:
		var doneTravelRight:bool = travel.x > 0 and self.position.x >= travelEnd.x
		var doneTravelLeft:bool = travel.x < 0 and self.position.x <= travelEnd.x
		var doneTravelUp:bool = travel.y < 0 and self.position.y <= travelEnd.y
		var doneTravelDown:bool = travel.y > 0 and self.position.y >= travelEnd.y
		if doneTravelRight or doneTravelLeft:
			self.velocity = Vector2.ZERO
			self.position.x = travelEnd.x
			travel = Vector2.ZERO
		if doneTravelUp or doneTravelDown:
			self.velocity = Vector2.ZERO
			self.position.y = travelEnd.y
			travel = Vector2.ZERO
		move_and_slide()

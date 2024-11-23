extends CharacterBody2D

const SPEED:int = 170
const GRIDSPACE:int = 96

var travel:Vector2 = Vector2.ZERO
var travelEnd:Vector2 = Vector2.ZERO

@onready var animation = $AnimatedSprite2D
@onready var camera = $Camera2D

func get_input():
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D): return "right"
	elif Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A): return "left"
	elif Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W): return "up"
	elif Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S): return "down"
	return ""

func _ready():
	self.position = Vector2(48, 48)

func _process(_delta):
	if travel == Vector2.ZERO:
		animation.flip_h = false
		animation.play("player_down")
		var input = get_input()
		if input == "right" and not (self.position.x + GRIDSPACE >= camera.limit_right):
			travel = Vector2(SPEED,0)
			travelEnd.x = int(self.position.x + GRIDSPACE)
			animation.flip_h = false
			animation.play("player_right")
		if input == "left" and not (self.position.x - GRIDSPACE <= camera.limit_left):
			travel = Vector2(-SPEED,0)
			travelEnd.x = int(self.position.x - GRIDSPACE)
			animation.flip_h = true
			animation.play("player_right")
		if input == "up" and not (self.position.y - GRIDSPACE <= camera.limit_top):
			travel = Vector2(0, -SPEED)
			travelEnd.y = int(self.position.y - GRIDSPACE)
			animation.flip_h = false
			animation.play("player_up")
		if input == "down" and not (self.position.y + GRIDSPACE >= camera.limit_bottom):
			travel = Vector2(0, SPEED)
			travelEnd.y = int(self.position.y + GRIDSPACE)
			animation.flip_h = false
			animation.play("player_down")
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

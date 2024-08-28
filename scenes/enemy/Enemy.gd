extends CharacterBody2D

const SPEED:int = 200
const GRIDSPACE:int = 64

var travel:Vector2 = Vector2.ZERO
var travelEnd:Vector2 = Vector2.ZERO

var move:bool = false
var direction:Vector2 = Vector2.ZERO

var pauseWalkTimer:float = 0
var pauseWalkDuration:float = 0.2

var path:Array
var travelingToIndex:int = 0

var validPath:bool

func to_radians(degrees:float):
	return (degrees * PI) / 180

func rotate_towards(point:Vector2):
	self.rotation = 0
	if point.x > self.position.x: self.rotate(to_radians(270))
	elif point.x < self.position.x: self.rotate(to_radians(90))
	elif point.y > self.position.y: self.rotate(to_radians(0))
	elif point.y < self.position.y: self.rotate(to_radians(180))

func set_direction(point:Vector2):
	if point.x > self.position.x: direction = Vector2(1,0)
	elif point.x < self.position.x: direction = Vector2(-1,0)
	elif point.y > self.position.y: direction = Vector2(0,1)
	elif point.y < self.position.y: direction = Vector2(0,-1)

func set_travel_path_index():
	if travelingToIndex+1 < len(path): travelingToIndex = travelingToIndex + 1
	else: travelingToIndex = 0

func check_valid_path():
	if len(path) == 0: 
		print("Error: Invalid Enemy path. Path must contain at least one point.")
		return false
	for i in len(path):
		if typeof(path[i]) != typeof(Vector2.ZERO):
			print("Error: Invalid Enemy path. Path must be an array of Vector2")
			return false
	for i in len(path):
		if i+1 < len(path) and (not(path[i].x == path[i+1].x) and not(path[i].y == path[i+1].y)): 
			print("Error: Invalid Enemy path. Enemies can only move one axis at a time.")
			return false
	return true
	

func _ready():
	path = get_parent().path
	validPath = check_valid_path()
	if !validPath: return
	# Initialize enemy position
	self.position = path[travelingToIndex]
	set_travel_path_index()
	# Initialize enemy rotation 
	rotate_towards(path[travelingToIndex])
	# Initialize traversal variables
	set_direction(path[travelingToIndex])
	move = true
	
func _process(delta):
	if !validPath: return
	if travel == Vector2.ZERO:
		if move && direction == Vector2(1,0):
			move = false
			travel = Vector2(SPEED,0)
			travelEnd = Vector2(int(self.position.x + GRIDSPACE), self.position.y)
		if move && direction == Vector2(-1,0):
			move = false
			travel = Vector2(-SPEED,0)
			travelEnd = Vector2(int(self.position.x - GRIDSPACE), self.position.y)
		if move && direction == Vector2(0,1):
			move = false
			travel = Vector2(0, SPEED)
			travelEnd = Vector2(self.position.x, (self.position.y + GRIDSPACE))
		if move && direction == Vector2(0,-1):
			move = false
			travel = Vector2(0, -SPEED)
			travelEnd = Vector2(self.position.x, (self.position.y - GRIDSPACE))
		self.velocity = travel
	else:
		var doneTravelRight:bool = travel.x > 0 and self.position.x >= travelEnd.x and direction == Vector2(1,0)
		var doneTravelLeft:bool = travel.x < 0 and self.position.x <= travelEnd.x and direction == Vector2(-1,0)
		var doneTravelUp:bool = travel.y < 0 and self.position.y <= travelEnd.y and direction == Vector2(0,-1)
		var doneTravelDown:bool = travel.y > 0 and self.position.y >= travelEnd.y and direction == Vector2(0,1)
		
		if (doneTravelRight or doneTravelLeft or doneTravelDown or doneTravelUp) && pauseWalkTimer == 0:
			self.velocity = Vector2.ZERO
			self.position = travelEnd
			var atPointX = (self.position.x <= path[travelingToIndex].x and doneTravelLeft) or (self.position.x >= path[travelingToIndex].x and doneTravelRight)
			var atPointY = (self.position.y <= path[travelingToIndex].y and doneTravelUp) or (self.position.y >= path[travelingToIndex].y and doneTravelDown)
			if atPointX or atPointY: 
				set_travel_path_index()
				rotate_towards(path[travelingToIndex])
				set_direction(path[travelingToIndex])
			pauseWalkTimer = pauseWalkTimer + delta
		elif pauseWalkTimer > 0:
			pauseWalkTimer = pauseWalkTimer + delta
			if pauseWalkTimer > pauseWalkDuration:
				travel = Vector2.ZERO
				pauseWalkTimer = 0
				move = true 
			
		move_and_slide()

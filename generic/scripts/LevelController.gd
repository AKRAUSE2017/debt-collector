extends Node

var nodes = []
var nodeIndex = 0

@export var activeNode:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = self.get_children()
	nodes = children
	if len(nodes): activeNode = nodes[nodeIndex]

func nextTurn():
	if nodeIndex + 1 == len(nodes): nodeIndex = 0
	else: nodeIndex = nodeIndex + 1
	activeNode = nodes[nodeIndex]

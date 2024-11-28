#Used for the UI of the inventory
extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres") #preload the player's inventory
@onready var slots: Array = $NinePatchRect/GridContainer.get_children() #the slots that items can be placed into

var is_open = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots(): #check all the slots and update the slots to the proper item texture
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta): #action to open/close inventory
	if Input.is_action_just_pressed("inv"):
		if is_open:
			close()
		else:
			open()

func open(): #way to have open inventory
	visible = true
	is_open = true

func close(): #way to have close inventory
	visible = false
	is_open = false


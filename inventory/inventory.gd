#the inventory class
extends Resource

class_name Inv

signal update #used to update in_ui 

@export var slots: Array[InvSlot] #Exports what's in the slots => an array of inventory slots

func insert(item: InvItem): #places items into slots
	var itemslots = slots.filter(func(slot): return slot.item == item) #looks for already existing item in slot
	if !itemslots.is_empty(): #if the first slot is open add the item to it 
		itemslots[0].amount += 1
	else: 
		var emptyslots = slots.filter(func(slot): return slot.item == null) #looks to see if the item being added doesn't exist in any slot
		if !emptyslots.is_empty(): #creates new slot for the item
			emptyslots[0].item = item #that slot is made that item 
			emptyslots[0].amount = 1 #sets the item amount to 1 since it is the first added
	update.emit() #sends signal to update inv_ui

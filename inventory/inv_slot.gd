#InventorySlot class that is exporting items and their amount in the slots
extends Resource

class_name InvSlot

@export var item: InvItem #stores whatever item the slot is holding
@export var amount: int #stores the amount of that specific item the slot is holding

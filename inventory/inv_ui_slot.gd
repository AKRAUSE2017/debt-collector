#Used for the slots of the inventory
extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display #this is to have the item centered in the slot
@onready var amount_text: Label = $CenterContainer/Panel/Label #this is the amount of the item

func update(slot: InvSlot): #update item that is displayed in the slot
	if !slot.item: #if there's no item then there isn't an item to show
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
			amount_text.text = str(slot.amount)

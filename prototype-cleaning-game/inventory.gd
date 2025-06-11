extends Resource

class_name Inventory

signal updated
var itemSelected = false

@export var slots: Array[InvSlot]

#Inserts an item into the inventory slot. Emits to update UI slot
func insert(item: InvItem):
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			updated.emit()
			return

#Removes an item at a specific index
func remove_item_at_index(index: int):
	slots[index] = InvSlot.new()

#Inserts item into new slot
func insert_slot(index: int, inventory_slot: InvSlot):
	var old_index: int = slots.find(inventory_slot)
	remove_item_at_index(old_index)
	
	slots[index] = inventory_slot

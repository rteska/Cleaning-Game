extends Button

@onready var inventory: Inventory = preload("res://Inventory/main_inventory.tres")
@onready var background_sprite: Sprite2D = $Sprite2D
@onready var container: CenterContainer = $CenterContainer


var item_stack_ui: ItemStack
var index: int

signal change_cursor_slot

# Updates slots UI
func insert(isg: ItemStack):
	item_stack_ui = isg
	container.add_child(item_stack_ui)
	
	if !item_stack_ui.inventory_slot || inventory.slots[index] == item_stack_ui.inventory_slot:
		return
	
	inventory.insert_slot(index, item_stack_ui.inventory_slot)

# Removes slot item
func take_item():
	var item = item_stack_ui
	
	container.remove_child(item_stack_ui)
	item_stack_ui = null
	
	return item

#Checks to see if a stack is empty
func is_empty():
	return !item_stack_ui

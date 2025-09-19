extends Control

@onready var inv: Inventory = preload("res://Inventory/main_inventory.tres")
@onready var item_stack_class = preload("res://item_stack_ui.tscn")
@onready var player = preload("res://player.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var item_in_hand: ItemStack

var is_open = false
var selected_item: InvItem

var already_called = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_slots()
	inv.updated.connect(update)
	update()
	#close()

func _process(float) -> void:
	if Input.is_action_pressed("interact") && !already_called:
		already_called = true
		$Hold_delay.start()
	elif Input.is_action_just_released("interact"):
		$NinePatchRect.visible = true
		pass

#Binds items to their slots
func connect_slots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
		var callable = Callable(click_slot)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

#Updates inventory ui, stack ui, and slots
func update():
	for i in range(min(inv.slots.size(), slots.size())):
		var inventory_slot: InvSlot = inv.slots[i]
		
		if !inventory_slot.item: continue
		
		var item_stack_ui: ItemStack = slots[i].item_stack_ui
		if !item_stack_ui:
			item_stack_ui = item_stack_class.instantiate()
			slots[i].insert(item_stack_ui)
			
		item_stack_ui.inventory_slot = inventory_slot
		item_stack_ui.update()


#Closes the inventory UI
func close():
	visible = false
	is_open = false

# Opens the inventory UI
func open():
	visible = true
	is_open = true
	

# Updates the slots for the inventory UI
func update_UI_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

# Clicks on item in slot. If item is already held, insert it into empty slot. 
# If there is no item in hand, take item
func click_slot(slot):
	if slot.is_empty(): #Is the slot empty
		if !item_in_hand: return #If there is no item in hand, return, else place item
		insert_item_in_slot(slot)
		return
	if !item_in_hand: #Is there an item in hand. If not, take item
		take_item_from_slot(slot)
		return
	if slot.item_stack_ui.inventory_slot.item.combines_with == item_in_hand.inventory_slot.item.name: #Combine items
		combine_items(slot)
		return
	#swap(slot)
	
# Removes item from inventory slot
func take_item_from_slot(slot):
	item_in_hand = slot.take_item()
	add_child(item_in_hand)
	Globals.item_held = item_in_hand.inventory_slot.item
	update_item_in_hand()

# Inserts a held item into an empty slot
func insert_item_in_slot(slot):
	var item = item_in_hand
	remove_child(item_in_hand)
	item_in_hand = null
	Globals.item_held = null
	slot.insert(item)

#Updates what item is in hand
func update_item_in_hand():
	if !item_in_hand: return
	
	item_in_hand.global_position = get_global_mouse_position() - item_in_hand.size / 2
	
#Registers that any input should update item in hand
func _input(event):
	update_item_in_hand()

func swap(slot):
	var temp_item = slot.take_item()
	
	insert_item_in_slot(slot)
	
	item_in_hand = temp_item
	add_child(item_in_hand)
	update_item_in_hand()
	

#Return held item to its previous slot and change the combined item
func combine_items(slot): 
	if (item_in_hand.inventory_slot.item.name == "Cloth_dry_blue" || item_in_hand.inventory_slot.item.name == "Cloth_dry_red"): #The cloth is in hand
		item_in_hand.inventory_slot.item.texture = item_in_hand.inventory_slot.item.alt_item_image
		remove_child(item_in_hand)
		item_in_hand = null
		Globals.item_held = null
		$SpraySFX.play()
		update_item_in_hand()
		#update_UI_slots()
		update()
	elif (item_in_hand.inventory_slot.item.name == "Cleaner_blue" || item_in_hand.inventory_slot.item.name == "Cleaner_red"): #The cleaner is in hand
		slot.item_stack_ui.inventory_slot.item.texture = slot.item_stack_ui.inventory_slot.item.alt_item_image
		remove_child(item_in_hand)
		item_in_hand = null
		Globals.item_held = null
		$SpraySFX.play()
		update_item_in_hand()
		#update_UI_slots()
		update()
	elif (item_in_hand.inventory_slot.item.name == "Mop"): #Mop in hand
		item_in_hand.inventory_slot.item.texture = item_in_hand.inventory_slot.item.alt_item_image
		remove_child(item_in_hand)
		item_in_hand = null
		Globals.item_held = null
		$DipSFX.play()
		update_item_in_hand()
		update()
	else: #Bucket in hand
		slot.item_stack_ui.inventory_slot.item.texture = slot.item_stack_ui.inventory_slot.item.alt_item_image
		remove_child(item_in_hand)
		item_in_hand = null
		Globals.item_held = null
		$DipSFX.play()
		update_item_in_hand()
		update()
		pass


func _on_hold_delay_timeout() -> void:
	if Input.is_action_pressed("interact"):
		$NinePatchRect.visible = false
		already_called = false
	else:
		already_called = false

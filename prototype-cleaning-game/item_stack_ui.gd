extends Panel

class_name ItemStack

@onready var item_visual: Sprite2D = $item_display

var inventory_slot

# Updates stack UI
func update():
	if !inventory_slot || !inventory_slot.item: return
	
	item_visual.visible = true
	item_visual.texture = inventory_slot.item.texture
	

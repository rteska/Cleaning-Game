extends Node2D

@export var clean_wipe_item : InvItem
@export var dirty_wipe_item : InvItem

var clean_visible = true
var dirty_visible = false
var in_area = false

var changed_wipe = false

var counter = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position = get_global_mouse_position()
	
	if counter >= 50 && !in_area && !changed_wipe:
		change_wipe()
		changed_wipe = true

func change_wipe():
	$Clean.visible = false
	clean_visible = false
	$Dirty.visible = true
	dirty_visible = true
	Globals.item_held = dirty_wipe_item
	

func get_clean_visibility():
	return clean_visible

func get_dirty_visibility():
	return dirty_visible

func get_current_wipe():
	if clean_visible:
		return clean_wipe_item
	else:
		return dirty_wipe_item

func currently_in_area():
	in_area = true
	

func left_area():
	in_area = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Staph" && Input.is_action_pressed("interact"):
		counter += 1
	

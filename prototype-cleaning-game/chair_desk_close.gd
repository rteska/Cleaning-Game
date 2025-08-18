extends Node2D

const bacteriaPath = preload("res://staph.tscn")

@export var back_rest_bl = Node2D
@export var back_rest_tr = Node2D
@export var arm_rest_bl_left = Node2D
@export var arm_rest_tr_left = Node2D
@export var arm_rest_bl_right = Node2D
@export var arm_rest_tr_right = Node2D
@export var seat_bl = Node2D
@export var seat_tr = Node2D

var centerPos = global_position
var Chair_desk_close_cleaned = false
var alreadyGenerated = false

var total = 30
var chair_desk_score = 0
var score_added = false

signal completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the chair by the desk
func _on_main_spawn_bacteria() -> void:
	
	if !Chair_desk_close_cleaned && !alreadyGenerated:
			
		for i in range(5): #Create a bacteria cluster on the backrest
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(back_rest_bl.position.x, back_rest_tr.position.x), randf_range(back_rest_bl.position.y, back_rest_tr.position.y)) 
			add_child(bacteria)
			
		for i in range(10): #Create a bacteria cluster on the left arm rest
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(arm_rest_bl_left.position.x, arm_rest_tr_left.position.x), randf_range(arm_rest_bl_left.position.y, arm_rest_tr_left.position.y))
			add_child(bacteria)
			
		for i in range(10): #Create a bacteria cluster on the right arm rest
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(arm_rest_bl_right.position.x, arm_rest_tr_right.position.x), randf_range(arm_rest_bl_right.position.y, arm_rest_tr_right.position.y))
			add_child(bacteria)
		
		for i in range(5): #Create a bacteria cluster on the seat
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(seat_bl.position.x, seat_tr.position.x), randf_range(seat_bl.position.y, seat_tr.position.y))
			add_child(bacteria)
		
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true

#Hides the bacteria when leaving the scene	
func _on_leave_chair_desk_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		Globals.score += chair_desk_score
		score_added = true

func add_score():
	chair_desk_score += 1
	total -= 1

func remove_score():
	total -= 1

extends Node2D

const bacteriaPath = preload("res://candida.tscn")

@export var floor1_bl = Node2D
@export var floor1_tr = Node2D
@export var floor2_bl = Node2D
@export var floor2_tr = Node2D
@export var floor3_bl = Node2D
@export var floor3_tr = Node2D

var centerPos = global_position
var Main_room_floor_2_cleaned = false
var alreadyGenerated = false

var total = 15
var main_room_floor_2_score = 0
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
	
	if !Main_room_floor_2_cleaned && !alreadyGenerated:
			
		for i in range(5): 
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(floor1_bl.position.x, floor1_tr.position.x), randf_range(floor1_bl.position.y, floor1_tr.position.y)) 
			add_child(bacteria)
			
		for i in range(5):
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(floor2_bl.position.x, floor2_tr.position.x), randf_range(floor2_bl.position.y, floor2_tr.position.y))
			add_child(bacteria)
			
		for i in range(5): 
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(floor3_bl.position.x, floor3_tr.position.x), randf_range(floor3_bl.position.y, floor3_tr.position.y))
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
func _on_leave_main_room_floor_2_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		#Globals.score += chair_bed_score
		score_added = true

func add_score():
	main_room_floor_2_score += 1
	Globals.score += 1
	total -= 1

func remove_score():
	total -= 1

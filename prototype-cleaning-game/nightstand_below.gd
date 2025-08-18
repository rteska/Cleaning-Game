extends Node2D


const bacteriaPath = preload("res://staph.tscn")

@export var handle1_bl = Node2D
@export var handle1_tr = Node2D
@export var handle2_bl = Node2D
@export var handle2_tr = Node2D
@export var handle3_bl = Node2D
@export var handle3_tr = Node2D
@export var handle4_bl = Node2D
@export var handle4_tr = Node2D

var centerPos = global_position
var Nightstand_below_cleaned = false
var alreadyGenerated = false

var total = 16
var nightstand_below_score = 0
var score_added = false

signal completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the nightstand handles
func _on_main_spawn_bacteria() -> void:
	
	if !Nightstand_below_cleaned && !alreadyGenerated:
		for i in range(5): #Create a concentrated bacteria cluster on the first handle
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(handle1_bl.position.x, handle1_tr.position.x), randf_range(handle1_bl.position.y, handle1_tr.position.y))
			add_child(bacteria)
			
		for i in range(5): #Create a concentrated bacteria cluster on the second handle
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(handle2_bl.position.x, handle2_tr.position.x), randf_range(handle2_bl.position.y, handle2_tr.position.y))
			add_child(bacteria)
		
		for i in range(3): #Create a sparse bacteria cluster on the third handle
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(handle3_bl.position.x, handle3_tr.position.x), randf_range(handle3_bl.position.y, handle3_tr.position.y))
			add_child(bacteria)
			
		for i in range(3): #Create a sparse bacteria cluster on the fourth handle
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(handle4_bl.position.x, handle4_tr.position.x), randf_range(handle4_bl.position.y, handle4_tr.position.y)) 
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
func _on_leave_nightstand_below_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		Globals.score += nightstand_below_score
		score_added = true

func add_score():
	nightstand_below_score += 1
	total -= 1

func remove_score():
	total -= 1

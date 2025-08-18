extends Node2D


const bacteriaPath = preload("res://enterococcus.tscn")

@export var handle_bl = Node2D
@export var handle_tr = Node2D
@export var holder_bl = Node2D
@export var holder_tr = Node2D

var centerPos = global_position
var Shower_handle_cleaned = false
var alreadyGenerated = false

signal completed

var total = 15
var shower_handle_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the soap dispenser
func _on_main_spawn_bacteria() -> void:
	if !Shower_handle_cleaned && !alreadyGenerated:
		
		for i in range(10): #Concentrated amount on the handle
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(handle_bl.position.x, handle_tr.position.x), randf_range(handle_bl.position.y, handle_tr.position.y))
			add_child(bacteria)
		
		for i in range(5): #Sparse amount on the holder
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(holder_bl.position.x, holder_tr.position.x), randf_range(holder_bl.position.y, holder_tr.position.y))
			add_child(bacteria)
			
			
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_shower_handle_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		Globals.score += shower_handle_score
		score_added = true


func add_score():
	shower_handle_score += 1
	total -= 1
	
func remove_score():
	total -= 1

extends Node2D

const bacteriaPath = preload("res://enterococcus.tscn")

@export var spout_bl = Node2D
@export var spout_tr = Node2D
@export var bowl_bl = Node2D
@export var bowl_tr = Node2D
@export var counter_bl = Node2D
@export var counter_tr = Node2D

var centerPos = global_position
var Sink_cleaned = false
var alreadyGenerated = false

signal completed

var total = 22
var sink_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the sink
func _on_main_spawn_bacteria() -> void:
	if !Sink_cleaned && !alreadyGenerated:
		
		for i in range(10): #Concentrated amount on the spout
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(spout_bl.position.x, spout_tr.position.x), randf_range(spout_bl.position.y, spout_tr.position.y))
			add_child(bacteria)
		
		for i in range(7): #Concentrated amount in the bowl
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(bowl_bl.position.x, bowl_tr.position.x), randf_range(bowl_bl.position.y, bowl_tr.position.y))
			add_child(bacteria)
			
			
		for i in range(5): #Sparse amount on the counter
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(counter_bl.position.x, counter_tr.position.x), randf_range(counter_bl.position.y, counter_tr.position.y))
			add_child(bacteria)
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_sink_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		#Globals.score += sink_score
		score_added = true


func add_score():
	sink_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1

extends Node2D


const bacteriaPath = preload("res://staph.tscn")

@export var table_bl = Node2D
@export var table_tr = Node2D

var centerPos = global_position
var Side_table_above_cleaned = false
var alreadyGenerated = false

signal completed

var total = 40
var side_table_above_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_spawn_bacteria() -> void:
	if !Side_table_above_cleaned && !alreadyGenerated:
		
		for i in range(40): #Concentrated amount on the table
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(table_bl.position.x, table_tr.position.x), randf_range(table_bl.position.y, table_tr.position.y))
			add_child(bacteria)
		
			
			
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_side_table_above_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	
	if total == 0 && !score_added:
		completed.emit()
		#Globals.score += side_table_above_score
		score_added = true


func add_score():
	side_table_above_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1

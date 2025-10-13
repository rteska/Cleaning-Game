extends Node2D


const bacteriaPath = preload("res://staph.tscn")

@export var lid_bl = Node2D
@export var lid_tr = Node2D
@export var bin_bl = Node2D
@export var bin_tr = Node2D

var centerPos = global_position
var Sharps_bin_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, door1, door2)

var total = 15
var total_score = 15
var sharps_bin_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_spawn_bacteria() -> void:
	if !Sharps_bin_cleaned && !alreadyGenerated:
		
		for i in range(10): #Concentrated amount on the lid
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(lid_bl.position.x, lid_tr.position.x), randf_range(lid_bl.position.y, lid_tr.position.y))
			add_child(bacteria)
		
		for i in range(5): #Sparse amount on the bin
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(bin_bl.position.x, bin_tr.position.x), randf_range(bin_bl.position.y, bin_tr.position.y))
			add_child(bacteria)
			
			
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_sharps_bin_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	
	if total == 0 && !score_added:
		completed.emit()
		pass_points.emit(sharps_bin_score, total_score, 0, 0)
		#Globals.score += sharps_bin_score
		score_added = true


func add_score():
	sharps_bin_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1

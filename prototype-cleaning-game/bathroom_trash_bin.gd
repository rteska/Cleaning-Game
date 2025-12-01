extends Node2D

const bacteriaPath = preload("res://enterococcus.tscn")

@export var lid_bl = Node2D
@export var lid_tr = Node2D

var centerPos = global_position
var Bathroom_trash_bin_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

var total = 5
var total_score = 5
var bathroom_trash_bin_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the bathroom trash bin
func _on_main_spawn_bacteria() -> void:
	if !Bathroom_trash_bin_cleaned && !alreadyGenerated:
		
		for i in range(5): #Concentrated amount on the lid
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(lid_bl.position.x, lid_tr.position.x), randf_range(lid_bl.position.y, lid_tr.position.y))
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
		
		
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			#child.visible = true


func _on_leave_bathroom_trash_bin_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += sink_score
		score_added = true
	pass_points.emit(bathroom_trash_bin_score, total_score, 0, 0, self)


func add_score():
	bathroom_trash_bin_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	bathroom_trash_bin_score = 0
	total = 5
	score_added = false
	alreadyGenerated = false

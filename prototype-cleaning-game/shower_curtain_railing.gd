extends Node2D

const bacteriaPath = preload("res://enterococcus.tscn")

@export var railing1_bl = Node2D
@export var railing1_tr = Node2D
@export var railing2_bl = Node2D
@export var railing2_tr = Node2D
@export var railing3_bl = Node2D
@export var railing3_tr = Node2D

var centerPos = global_position
var Shower_curtain_rod_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

var total = 19
var total_score = 19
var shower_curtain_rod_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the shower curtain
func _on_main_spawn_bacteria() -> void:
	if !Shower_curtain_rod_cleaned && !alreadyGenerated:
		
		for i in range(7): #Concentrated amount on the first handle
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(railing1_bl.position.x, railing1_tr.position.x), randf_range(railing1_bl.position.y, railing1_tr.position.y))
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
			
		for i in range(7): #Concentrated amount on the second handle
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(railing2_bl.position.x, railing2_tr.position.x), randf_range(railing2_bl.position.y, railing2_tr.position.y))
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
		
		for i in range(5): #Sparse amount on curain rod
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(railing3_bl.position.x, railing3_tr.position.x), randf_range(railing3_bl.position.y, railing3_tr.position.y))
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


func _on_leave_shower_curtain_rod_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += shower_handle_score
		score_added = true
	pass_points.emit(shower_curtain_rod_score, total_score, 0, 0, self)


func add_score():
	shower_curtain_rod_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	shower_curtain_rod_score = 0
	total = 19
	score_added = false
	alreadyGenerated = false

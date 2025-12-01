extends Node2D


const bacteriaPath = preload("res://staph.tscn")

@export var top1_bl = Node2D
@export var top1_tr = Node2D
@export var top2_bl = Node2D
@export var top2_tr = Node2D

var centerPos = global_position
var Nightstand_above_cleaned = false
var alreadyGenerated = false

var total = 10
var total_score = 10
var nightstand_above_score = 0
var score_added = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.current_scene != $"../Nightstand_above":
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", false)
					grandchildren.set_deferred("monitorable", false)
	else:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)

#Spawns one set of bacteria for the nightstand top
func _on_main_spawn_bacteria() -> void:
	
	if !Nightstand_above_cleaned && !alreadyGenerated:
		for i in range(5): #Create a sparse bacteria cluster left section
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(top1_bl.position.x, top1_tr.position.x), randf_range(top1_bl.position.y, top1_tr.position.y))
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
			
		for i in range(5): #Create a sparse bacteria cluster on the bottom section
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(top2_bl.position.x, top2_tr.position.x), randf_range(top2_bl.position.y, top2_tr.position.y)) 
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

#Hides the bacteria when leaving the scene	
func _on_leave_nightstand_above_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += nightstand_above_score
		score_added = true
	pass_points.emit(nightstand_above_score, total_score, 0, 0, self)

func add_score():
	nightstand_above_score += 1
	Globals.score += 1
	total -= 1

func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	nightstand_above_score = 0
	total = 10
	score_added = false
	alreadyGenerated = false

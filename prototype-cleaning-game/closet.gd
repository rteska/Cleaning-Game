extends Node2D


const bacteriaPath = preload("res://staph.tscn")

@export var handle_bl = Node2D
@export var handle_tr = Node2D
@export var door_bl = Node2D
@export var door_tr = Node2D

var centerPos = global_position
var Closet_cleaned = false
var alreadyGenerated = false

var total = 5
var total_score = 5
var Closet_score = 0
var score_added = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the switch, and panel
func _on_main_spawn_bacteria() -> void:
	
	if !Closet_cleaned && !alreadyGenerated:
		for i in range(3): #Create a concentrated bacteria cluster on the handle
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(handle_bl.position.x, handle_tr.position.x), randf_range(handle_bl.position.y, handle_tr.position.y))
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
			
		for i in range(2): #Create a sparse bacteria cluster on the door
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(door_bl.position.x, door_tr.position.x), randf_range(door_bl.position.y, door_tr.position.y)) 
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
func _on_leave_closet_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += Closet_score
		score_added = true
	pass_points.emit(Closet_score, total_score, 0, 0, self)

func add_score():
	Closet_score += 1
	Globals.score += 1
	total -= 1

func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	Closet_score = 0
	total = 5
	score_added = false
	alreadyGenerated = false

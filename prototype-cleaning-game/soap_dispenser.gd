extends Node2D


const bacteriaPath = preload("res://enterococcus.tscn")

@export var dispenser_bl = Node2D
@export var dispenser_tr = Node2D
@export var holder_bl = Node2D
@export var holder_tr = Node2D

var centerPos = global_position
var Soap_dispenser_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

var total = 15
var total_score = 15
var soap_dispenser_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the soap dispenser
func _on_main_spawn_bacteria() -> void:
	if !Soap_dispenser_cleaned && !alreadyGenerated:
		
		for i in range(10): #Concentrated amount on the dispenser
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(dispenser_bl.position.x, dispenser_tr.position.x), randf_range(dispenser_bl.position.y, dispenser_tr.position.y))
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
		
		for i in range(5): #Sparse amount on the holder
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(holder_bl.position.x, holder_tr.position.x), randf_range(holder_bl.position.y, holder_tr.position.y))
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


func _on_leave_soap_dispenser_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += soap_dispenser_score
		score_added = true
	pass_points.emit(soap_dispenser_score, total_score, 0, 0, self)


func add_score():
	soap_dispenser_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	soap_dispenser_score = 0
	total = 15
	score_added = false
	alreadyGenerated = false

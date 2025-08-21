extends Node2D

const bacteriaPath = preload("res://enterococcus.tscn")

@export var roll_left_bl = Node2D
@export var roll_left_tr = Node2D
@export var roll_right_bl = Node2D
@export var roll_right_tr = Node2D

var centerPos = global_position
var Toilet_roll_cleaned = false
var alreadyGenerated = false

signal completed

var total = 10
var toilet_roll_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the toilet roll
func _on_main_spawn_bacteria() -> void:
	if !Toilet_roll_cleaned && !alreadyGenerated:
		
		for i in range(5): #Sparse amount on the left of the roll
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(roll_left_bl.position.x, roll_left_tr.position.x), randf_range(roll_left_bl.position.y, roll_left_tr.position.y))
			add_child(bacteria)
		
		for i in range(5): #Sparse amount on the right of the roll
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(roll_right_bl.position.x, roll_right_tr.position.x), randf_range(roll_right_bl.position.y, roll_right_tr.position.y))
			add_child(bacteria)
		
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_toilet_roll_hide_bacteria() -> void:
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
	toilet_roll_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1

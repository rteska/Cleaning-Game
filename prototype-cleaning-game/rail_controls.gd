extends Node2D


const bacteriaPath = preload("res://staph.tscn")

@export var controls_bl = Node2D
@export var controls_tr = Node2D

var centerPos = global_position
var Rail_controls_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

var total = 10
var total_score = 10
var rail_controls_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_spawn_bacteria() -> void:
	if !Rail_controls_cleaned && !alreadyGenerated:
		
		for i in range(10): #Concentrated amount on the table
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(controls_bl.position.x, controls_tr.position.x), randf_range(controls_bl.position.y, controls_tr.position.y))
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


func _on_leave_rail_controls_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += rail_controls_score
		score_added = true
	pass_points.emit(rail_controls_score, total_score, 0, 0, self)


func add_score():
	rail_controls_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	rail_controls_score = 0
	total = 10
	score_added = false
	alreadyGenerated = false

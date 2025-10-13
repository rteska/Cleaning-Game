extends Node2D


const bacteriaPath = preload("res://enterococcus.tscn")

@export var bar_bl = Node2D
@export var bar_tr = Node2D

var centerPos = global_position
var Toilet_bar_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, door1, door2)

var total = 15
var total_score = 15
var toilet_bar_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the toilet bar
func _on_main_spawn_bacteria() -> void:
	if !Toilet_bar_cleaned && !alreadyGenerated:
		
		for i in range(15): #Concentrated amount on the bar
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(bar_bl.position.x, bar_tr.position.x), randf_range(bar_bl.position.y, bar_tr.position.y))
			add_child(bacteria)
		
		
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_toilet_bar_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		pass_points.emit(toilet_bar_score, total_score, 0, 0)
		#Globals.score += sink_score
		score_added = true


func add_score():
	toilet_bar_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1

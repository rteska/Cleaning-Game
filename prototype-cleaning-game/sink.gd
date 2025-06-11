extends Node2D

const bacteriaPath = preload("res://c_diff.tscn")

var centerPos = global_position
var Sink_cleaned = false
var alreadyGenerated = false

signal completed

var total = 110
var sink_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_spawn_bacteria() -> void:
	if !Sink_cleaned && !alreadyGenerated:
		for i in range(20): #Concentrated amount on the faucet and handles
			var bacteria = bacteriaPath.instantiate()
			bacteria.play_animation()
			
			bacteria.position = position + Vector2(randf_range(-575, -425), randf_range(-500, -475))
			add_child(bacteria)
			
		for i in range(40): #Concentrated amount in the bowl
			var bacteria = bacteriaPath.instantiate()
			bacteria.play_animation()
			
			bacteria.position = position + Vector2(randf_range(-650, -400), randf_range(-400, -100))
			add_child(bacteria)
			
			
		for i in range(50): #Sparse amount on the counter
			var bacteria = bacteriaPath.instantiate()
			bacteria.play_animation()
			
			bacteria.position = position + Vector2(randf_range(-1000, 0), randf_range(-500, -200))
			add_child(bacteria)
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_sink_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		Globals.score += sink_score
		score_added = true


func add_score():
	sink_score += 1
	total -= 1
	
func remove_score():
	total -= 1

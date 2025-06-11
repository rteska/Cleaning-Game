extends Node2D

const bacteriaPath = preload("res://staph.tscn")

var centerPos = global_position
var Chair_desk_close_cleaned = false
var alreadyGenerated = false

var total = 40
var chair_desk_score = 0
var score_added = false

signal completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the chair by the desk
func _on_main_spawn_bacteria() -> void:
	
	if !Chair_desk_close_cleaned && !alreadyGenerated:
		for i in range(30): #Create a bacteria cluster on the seat and arm rests
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = position + Vector2(randf_range(-750, -375), randf_range(-275,-100))
			add_child(bacteria)
			
		for i in range(10): #Create a bacteria cluster on the backrest
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = position + Vector2(randf_range(-700, -375), randf_range(-500, -350)) #X = [-850, -375] Y = [-350, -500]
			add_child(bacteria)
			
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true

#Hides the bacteria when leaving the scene	
func _on_leave_chair_desk_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		Globals.score += chair_desk_score
		score_added = true

func add_score():
	chair_desk_score += 1
	total -= 1

func remove_score():
	total -= 1

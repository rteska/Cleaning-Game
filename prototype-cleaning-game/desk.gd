extends Node2D

const bacteriaPath = preload("res://staph.tscn")

@export var desk_top_bl = Node2D
@export var desk_top_tr = Node2D

var centerPos = global_position
var Desk_top_cleaned = false
var alreadyGenerated = false

var total = 10
var desk_top_score = 0
var score_added = false

signal completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the computer screen, keyboard, and mouse
func _on_main_spawn_bacteria() -> void:
	
	if !Desk_top_cleaned && !alreadyGenerated:
		for i in range(10): #Create a bacteria cluster on the screen
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(desk_top_bl.position.x, desk_top_tr.position.x), randf_range(desk_top_bl.position.y, desk_top_tr.position.y))
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
func _on_leave_desk_top_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		Globals.score += desk_top_score
		score_added = true

func add_score():
	desk_top_score += 1
	total -= 1

func remove_score():
	total -= 1

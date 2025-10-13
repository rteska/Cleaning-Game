extends Node2D

const bacteriaPath = preload("res://staph.tscn")

@export var switch_bl = Node2D
@export var switch_tr = Node2D
@export var panel_bl = Node2D
@export var panel_tr = Node2D

var centerPos = global_position
var Light_switch_cleaned = false
var alreadyGenerated = false

var total = 7
var total_score = 7
var Light_switch_score = 0
var score_added = false

signal completed
signal pass_score(points, total_points, door_points1, door_points2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the switch, and panel
func _on_main_spawn_bacteria() -> void:
	
	if !Light_switch_cleaned && !alreadyGenerated:
		for i in range(5): #Create a concentrated bacteria cluster on the switch
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(switch_bl.position.x, switch_tr.position.x), randf_range(switch_bl.position.y, switch_tr.position.y))
			add_child(bacteria)
			
		for i in range(2): #Create a sparse bacteria cluster on the panel
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(panel_bl.position.x, panel_tr.position.x), randf_range(panel_bl.position.y, panel_tr.position.y)) 
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
func _on_leave_light_switch_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		pass_score.emit(Light_switch_score, total_score, 0, 0)
		#Globals.score += Light_switch_score
		score_added = true

func add_score():
	Light_switch_score += 1
	Globals.score += 1
	total -= 1

func remove_score():
	total -= 1

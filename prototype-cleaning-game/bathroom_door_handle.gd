extends Node2D

const bacteriaPath = preload("res://enterococcus.tscn")

@export var in_handle_bl = Node2D
@export var in_handle_tr = Node2D
@export var out_handle_bl = Node2D
@export var out_handle_tr = Node2D

var centerPos = global_position
var Door_handle_out_cleaned = false
var Door_handle_in_cleaned = false
var alreadyGenerated = false

var total = 20
var Door_handles_score = 0
var score_added = false

signal completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the door handles both inside and out
func _on_main_spawn_bacteria() -> void:
	
	if !Door_handle_out_cleaned && !Door_handle_in_cleaned && !alreadyGenerated:
		for i in range(10): #Create a bacteria cluster on the outside handle
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(out_handle_bl.position.x, out_handle_tr.position.x), randf_range(out_handle_bl.position.y, out_handle_tr.position.y))
			$Out.add_child(bacteria)
			
		for i in range(10): #Create a bacteria cluster on the inside handle
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(in_handle_bl.position.x, in_handle_tr.position.x), randf_range(in_handle_bl.position.y, in_handle_tr.position.y)) 
			$In.add_child(bacteria)
		
		
		alreadyGenerated = true
	
	
	if alreadyGenerated:
		for child in $In.get_children():
			for grandchildren in child.get_children():
					if grandchildren is Area2D:
						grandchildren.set_deferred("monitoring", true)
						grandchildren.set_deferred("monitorable", true)
					#grandchildren.visible = true
		for child in $Out.get_children():
			for grandchildren in child.get_children():
					if grandchildren is Area2D:
						grandchildren.set_deferred("monitoring", false)
						grandchildren.set_deferred("monitorable", false)
					#grandchildren.visible = false

func on_leave_in_bathroom_door_hide_bacteria():
	for child in $In.get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
				#grandchildren.visible = true
	for child in $Out.get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", true)
				grandchildren.set_deferred("monitorable", true)
				#grandchildren.visible = false
	

func on_leave_out_bathroom_door_hide_bacteria():
	for child in $In.get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", true)
				grandchildren.set_deferred("monitorable", true)
				#grandchildren.visible = true
	for child in $Out.get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
				#grandchildren.visible = false

#Hides the bacteria when leaving the scene	
func _on_leave_bathroom_door_hide_bacteria() -> void:
	$Out.visible = false
	$In.visible = true
	for child in get_children():
		for grandchildren in child.get_children():
			for greatgrandchildren in grandchildren.get_children():
				if greatgrandchildren is Area2D:
					greatgrandchildren.set_deferred("monitoring", false)
					greatgrandchildren.set_deferred("monitorable", false)
				#greatgrandchildren.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		#Globals.score += Door_handles_score
		score_added = true

func add_score():
	Door_handles_score += 1
	Globals.score += 1
	total -= 1

func remove_score():
	total -= 1

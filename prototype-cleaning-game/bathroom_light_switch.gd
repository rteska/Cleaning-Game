extends Node2D

const bacteriaPath = preload("res://enterococcus.tscn")

@export var switch_bl = Node2D
@export var switch_tr = Node2D

var centerPos = global_position
var Bathroom_light_switch_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, doorpoints1, doorpoints2)

var total = 10
var total_score = 10
var bathroom_light_switch_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates bacteria on the bathroom light switch
func _on_main_spawn_bacteria() -> void:
	if !Bathroom_light_switch_cleaned && !alreadyGenerated:
		
		for i in range(10): #Concentrated amount on the switch
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(switch_bl.position.x, switch_tr.position.x), randf_range(switch_bl.position.y, switch_tr.position.y))
			add_child(bacteria)
		
		
		alreadyGenerated = true
	
	if alreadyGenerated:
		for child in get_children():
			for grandchildren in child.get_children():
				if grandchildren is Area2D:
					grandchildren.set_deferred("monitoring", true)
					grandchildren.set_deferred("monitorable", true)
			child.visible = true


func _on_leave_bathroom_light_switch_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		pass_points.emit(bathroom_light_switch_score, total_score, 0, 0)
		#Globals.score += sink_score
		score_added = true


func add_score():
	bathroom_light_switch_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1

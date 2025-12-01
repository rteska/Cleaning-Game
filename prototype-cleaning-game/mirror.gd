extends Node2D

const bacteriaPath = preload("res://enterococcus.tscn")

@export var mirror_bl = Node2D
@export var mirror_tr = Node2D


var centerPos = global_position
var Mirror_cleaned = false
var alreadyGenerated = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

var total = 5
var total_score = 5
var mirror_score = 0
var score_added = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Spawns bacteria on the mirror
func _on_main_spawn_bacteria() -> void:
	if !Mirror_cleaned && !alreadyGenerated:
		
		for i in range(5): #Sparse amount on the surface
			var bacteria = bacteriaPath.instantiate()
			#bacteria.play_animation()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(mirror_bl.position.x, mirror_tr.position.x), randf_range(mirror_bl.position.y, mirror_tr.position.y))
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


func _on_leave_mirror_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += mirror_score
		score_added = true
	pass_points.emit(mirror_score, total_score, 0, 0, self)


func add_score():
	mirror_score += 1
	Globals.score += 1
	total -= 1
	
func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	mirror_score = 0
	total = 5
	score_added = false
	alreadyGenerated = false

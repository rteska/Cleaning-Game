extends Node2D
const bacteriaPath = preload("res://staph.tscn")

@export var screen_bl = Node2D
@export var screen_tr = Node2D
@export var mouse_bl = Node2D
@export var mouse_tr = Node2D
@export var keyboard_bl = Node2D
@export var keyboard_tr = Node2D

var centerPos = global_position
var Computer_screen_cleaned = false
var alreadyGenerated = false

var total = 22
var total_score = 22
var Computer_screen_score = 0
var score_added = false

signal completed
signal pass_points(points, total_points, door1, door2)
signal hide_ultraviolet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the computer screen, keyboard, and mouse
func _on_main_spawn_bacteria() -> void:
	
	if !Computer_screen_cleaned && !alreadyGenerated:
		for i in range(2): #Create a bacteria cluster on the screen
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(screen_bl.position.x, screen_tr.position.x), randf_range(screen_bl.position.y, screen_tr.position.y))
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
			
		for i in range(10): #Create a bacteria cluster on the mouse
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(mouse_bl.position.x, mouse_tr.position.x), randf_range(mouse_bl.position.y, mouse_tr.position.y)) 
			if Globals.difficulty_mode:
				bacteria.visible = false
			add_child(bacteria)
		
		for i in range(10): #Create a bacteria cluster on the keyboard
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(keyboard_bl.position.x, keyboard_tr.position.x), randf_range(keyboard_bl.position.y, keyboard_tr.position.y)) 
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

#Hides the bacteria when leaving the scene	
func _on_leave_computer_screen_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		#child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		hide_ultraviolet.emit()
		#Globals.score += Computer_screen_score
		score_added = true
	pass_points.emit(Computer_screen_score, total_score, 0, 0, self)

func add_score():
	Computer_screen_score += 1
	Globals.score += 1
	total -= 1

func remove_score():
	total -= 1


func _on_main_reset_bacteria() -> void:
	total = 22
	Computer_screen_score = 0
	score_added = false
	alreadyGenerated = false

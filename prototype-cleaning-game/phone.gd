extends Node2D

const bacteriaPath = preload("res://staph.tscn")

@export var phone_bl = Node2D
@export var phone_tr = Node2D
@export var phone_holder_bl = Node2D
@export var phone_holder_tr = Node2D
@export var receiver_bl = Node2D
@export var receiver_tr = Node2D

var centerPos = global_position
var Phone_cleaned = false
var alreadyGenerated = false

var total = 15
var phone_score = 0
var score_added = false

signal completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Spawns one set of bacteria for the phone
func _on_main_spawn_bacteria() -> void:
	
	if !Phone_cleaned && !alreadyGenerated:
		for i in range(5): #Create a concentrated bacteria cluster on the phone
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(phone_bl.position.x, phone_tr.position.x), randf_range(phone_bl.position.y, phone_tr.position.y))
			add_child(bacteria)
		
		for i in range(5): #Create a concentrated bacteria cluster on the phone holder
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(phone_holder_bl.position.x, phone_holder_tr.position.x), randf_range(phone_holder_bl.position.y, phone_holder_tr.position.y))
			add_child(bacteria)
			
		for i in range(5): #Create a concentrated bacteria cluster on the receiver
			var bacteria = bacteriaPath.instantiate()
			
			bacteria.rotate_random()
			bacteria.position = Vector2(randf_range(receiver_bl.position.x, receiver_tr.position.x), randf_range(receiver_bl.position.y, receiver_tr.position.y)) 
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
func _on_leave_phone_hide_bacteria() -> void:
	for child in get_children():
		for grandchildren in child.get_children():
			if grandchildren is Area2D:
				grandchildren.set_deferred("monitoring", false)
				grandchildren.set_deferred("monitorable", false)
		child.visible = false
	
	if total == 0 && !score_added:
		completed.emit()
		Globals.score += phone_score
		score_added = true

func add_score():
	phone_score += 1
	total -= 1

func remove_score():
	total -= 1

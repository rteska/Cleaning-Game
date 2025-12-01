extends Node

var score = 0
var item_held
var current_scene
var previous_scene
var language_selected

var rooms_traversed = []
var rooms_missed = []
var rooms_truly_missed = []
var rooms_points = [[0, 5], [0, 5], [0, 7], [0, 15], [0, 15], [0, 10], [0, 30], [0, 5], [0, 22], [0, 5], [0, 30], [0, 10], [0, 15], [0, 16], [0, 40], [0, 10], [0, 10], [0, 10], [0, 10], [0, 5], [0, 22], [0, 15], [0, 15], [0, 19], [0, 5], [0, 10], [0, 15], [0, 10], [0, 15], [0, 5], [0, 20], [0, 35], [0, 15], [0, 35]]
var correct_rooms_order = []

var info_button_on = false
var difficulty_mode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D

var pointer = load("res://Art/Cursor_pointer.png")

# Called when the node enters the scene tree for the first time.
#Changes the cursor to the basic blue-hand
func _ready() -> void:
	Input.set_custom_mouse_cursor(pointer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func clean_bacteria(body):
	pass

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_animation():
	rotation_degrees = randf_range(0, 360)
	$AnimatedSprite2D.frame = randi_range(0, 1)
	$AnimatedSprite2D.play()

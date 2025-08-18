extends CanvasLayer

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func correct():
	$Correct.show()
	$ShowTimer.start()
	
func incorrect():
	$Incorrect.show()
	$ShowTimer.start()


func _on_show_timer_timeout() -> void:
	$Correct.hide()
	$Incorrect.hide()

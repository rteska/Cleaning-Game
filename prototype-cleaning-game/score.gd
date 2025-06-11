extends CanvasLayer

var base_text = " Score: "

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var text = str(base_text, str(Globals.score))
	$ColorRect/Label.text = text

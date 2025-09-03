extends Button

var isVisible = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if isVisible:
		$"../../BodyText_Game".visible = false
		isVisible = false
	else:
		$"../../BodyText_Game".visible = true
		isVisible = true
	
	


func _on_x_button_pressed() -> void:
	if isVisible:
		$"../../BodyText_Game".visible = false
		isVisible = false
	else:
		$"../../BodyText_Game".visible = true
		isVisible = true

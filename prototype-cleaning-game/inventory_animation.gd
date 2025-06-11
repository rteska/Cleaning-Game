extends AnimationPlayer

var ui_up = false

#var mouse_pos = get_viewport().get_mouse_position()
#var space = $Area2D.space()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	
	if(!ui_up):
		ui_up = true
		play("move_ui_up")
		
	


func _on_area_2d_mouse_exited() -> void:
	
	if(ui_up):
		play("move_ui_down")
		ui_up = false
	


func _on_cart_button_pressed() -> void:
	
	if(!ui_up):
		play("move_ui_up")
		ui_up = true
	else:
		play("move_ui_down")
		ui_up = false

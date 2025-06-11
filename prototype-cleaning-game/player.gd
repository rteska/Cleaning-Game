extends Area2D

const spray = preload("res://spray.tscn")

var screen_size

var item_held = null
var curr_area = null

var areas_overlapping

signal stop_sign

signal add_point_desk_chair
signal remove_point_desk_chair
signal add_point_sink
signal remove_point_sink


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = get_global_mouse_position()
	item_held = Globals.item_held
	
	areas_overlapping = get_overlapping_areas()
	
	if areas_overlapping != null:
		for areas in areas_overlapping:
			_on_area_entered(areas)
	
	if curr_area != null && item_held != null:
		if curr_area.get_name() == "Staph" || curr_area.get_name() == "C_diff":
			if (Input.is_action_just_released("interact")) && (str(item_held.texture.get_path().get_file()).contains("Cleaner_blue_item") || str(item_held.texture.get_path().get_file()).contains("Cleaner_red_item")):
				stop_sign.emit()
				$WipeIncorrectSFX.play()


func _on_area_entered(area: Area2D) -> void:
	curr_area = area
	if item_held != null && (area.get_name() == "Staph" || area.get_name() == "C_diff"): #are we holding an item at all
		if (Input.is_action_pressed("interact")) && (str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue") || str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red")):
			if area.get_name() == "Staph" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue"): #Blue cloth on Staph cells
				area.get_parent().queue_free()
				if Globals.current_scene == $"../Chair_desk_close":
					add_point_desk_chair.emit()
					$WipeCorrectSFX.play()
			elif area.get_name() == "C_diff" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red"): #Red cloth on C diff. cells
				area.get_parent().queue_free()
				if Globals.current_scene == $"../Sink":
					add_point_sink.emit()
					$WipeCorrectSFX.play()
			elif area.get_name() == "C_diff" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue"): #Blue cloth on C diff. cells
				area.get_parent().queue_free()
				if Globals.current_scene == $"../Sink":
					remove_point_sink.emit()
					$WipeIncorrectSFX.play()
			elif area.get_name() == "Staph" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red"): #Red cloth on Staph cells
				area.get_parent().queue_free()
				if Globals.current_scene == $"../Chair_desk_close":
					remove_point_desk_chair.emit()
					$WipeIncorrectSFX.play()
			elif area.get_name() == "Spray_area" && (str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue") || str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red")): #Hit spray
				area.get_parent().queue_free()
				
	pass
	


func _on_area_exited(area: Area2D) -> void:
	curr_area = null

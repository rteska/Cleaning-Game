extends Area2D

const spray = preload("res://spray.tscn")



var screen_size
var index = 0

var item_held = null
var curr_area = null

var areas_overlapping

signal stop_sign
signal correct
signal incorrect

signal add_point_desk_chair
signal remove_point_desk_chair

signal add_point_computer_screen
signal remove_point_computer_screen

signal add_point_computer
signal remove_point_computer

signal add_point_light_switch
signal remove_point_light_switch

signal add_point_front_door
signal remove_point_front_door

signal add_point_sharps_bin
signal remove_point_sharps_bin

signal add_point_trash_bin
signal remove_point_trash_bin

signal add_point_desk
signal remove_point_desk

signal add_point_chair_bed
signal remove_point_chair_bed

signal add_point_closet
signal remove_point_closet

signal add_point_nightstand_above
signal remove_point_nightstand_above

signal add_point_phone
signal remove_point_phone

signal add_point_nightstand_open
signal remove_point_nightstand_open

signal add_point_nightstand_below
signal remove_point_nightstand_below

signal add_point_side_table_above
signal remove_point_side_table_above

signal add_point_rail_controls
signal remove_point_rail_controls

signal add_point_sink
signal remove_point_sink

signal add_point_mirror
signal remove_point_mirror

signal add_point_soap_dispenser
signal remove_point_soap_dispenser

signal add_point_shower_handle
signal remove_point_shower_handle

signal add_point_shower_head
signal remove_point_shower_head

signal add_point_shower_curtain_railing
signal remove_point_shower_curtain_railing

var scenes_list
var signals_list = [[add_point_desk_chair, remove_point_desk_chair], [add_point_computer_screen, remove_point_computer_screen], [add_point_computer, remove_point_computer], 
[add_point_light_switch, remove_point_light_switch], [add_point_sharps_bin, remove_point_sharps_bin], 
[add_point_trash_bin, remove_point_trash_bin], [add_point_desk, remove_point_desk], [add_point_chair_bed, remove_point_chair_bed], 
[add_point_closet, remove_point_closet], [add_point_nightstand_above, remove_point_nightstand_above], [add_point_phone, remove_point_phone], 
[add_point_nightstand_open, remove_point_nightstand_open], [add_point_nightstand_below, remove_point_nightstand_below], [add_point_side_table_above, remove_point_side_table_above], 
[add_point_rail_controls, remove_point_rail_controls], [add_point_sink, remove_point_sink], [add_point_mirror, remove_point_mirror],
[add_point_soap_dispenser, remove_point_soap_dispenser], [add_point_shower_handle, remove_point_shower_handle], [add_point_shower_head, remove_point_shower_head],
[add_point_shower_curtain_railing, remove_point_shower_curtain_railing]]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	scenes_list = [$"../PatientRoom1/Chair_desk_close", $"../PatientRoom1/Computer_screen", $"../PatientRoom1/Computer", $"../PatientRoom1/Light_switch",
	$"../PatientRoom1/Sharps_bin", $"../PatientRoom1/Trash_bin", $"../PatientRoom1/Desk", $"../PatientRoom1/Chair_bed", $"../PatientRoom1/Closet",
	$"../PatientRoom1/Nightstand_above", $"../PatientRoom1/Phone", $"../PatientRoom1/Nightstand_open", $"../PatientRoom1/Nightstand_below",
	$"../PatientRoom1/Side_table_above", $"../PatientRoom1/Rail_controls",  $"../PatientRoom1/Sink", $"../PatientRoom1/Mirror", $"../PatientRoom1/Soap_dispenser",
	$"../PatientRoom1/Shower_handle", $"../PatientRoom1/Shower_head", $"../PatientRoom1/Shower_curtain_railing"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = get_global_mouse_position()
	item_held = Globals.item_held
	
	areas_overlapping = get_overlapping_areas()
	
	if areas_overlapping != null:
		for areas in areas_overlapping:
			_on_area_entered(areas)
	
	if curr_area != null && item_held != null:
		if curr_area.get_name() == "Staph" || curr_area.get_name() == "Enterococcus":
			if (Input.is_action_just_released("interact")) && (str(item_held.texture.get_path().get_file()).contains("Cleaner_blue_item") || str(item_held.texture.get_path().get_file()).contains("Cleaner_red_item")):
				stop_sign.emit()
				$WipeIncorrectSFX.play()


func _on_area_entered(area: Area2D) -> void:
	curr_area = area
	if item_held != null && (area.get_name() == "Staph" || area.get_name() == "Enterococcus"): #are we holding an item at all
		if (Input.is_action_pressed("interact")) && (str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue") || str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red")):
			if area.get_name() == "Staph" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue"): #Blue cloth on Staph cells
				area.get_parent().queue_free()
				for scene in scenes_list:
					if Globals.current_scene == scene:
						signals_list[index][0].emit()
						correct.emit()
						$WipeCorrectSFX.play()
						index = 0
						break
					elif Globals.current_scene == $"../PatientRoom1/Front_door/Closed" || Globals.current_scene == $"../PatientRoom1/Front_door/Open":
						add_point_front_door.emit()
						correct.emit()
						$WipeCorrectSFX.play()
						index = 0
						break
					index += 1
				#if Globals.current_scene == $"../PatientRoom1/Front_door/Closed" || $"../PatientRoom1/Front_door/Open":
					#add_point_front_door.emit()
					#correct.emit()
					#$WipeCorrectSFX.play()

			elif area.get_name() == "Enterococcus" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red"): #Red cloth on C diff. cells
				area.get_parent().queue_free()
				for scene in scenes_list:
					if Globals.current_scene == scene:
						signals_list[index][0].emit()
						correct.emit()
						$WipeCorrectSFX.play()
						index = 0
						break
					index += 1
			elif area.get_name() == "Enterococcus" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue"): #Blue cloth on C diff. cells
				area.get_parent().queue_free()
				for scene in scenes_list:
					if Globals.current_scene == scene:
						signals_list[index][1].emit()
						incorrect.emit()
						$WipeIncorrectSFX.play()
						index = 0
						break
					index += 1
			elif area.get_name() == "Staph" && str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red"): #Red cloth on Staph cells
				area.get_parent().queue_free()
				
				for scene in scenes_list:
					if Globals.current_scene == scene: 
						signals_list[index][1].emit()
						incorrect.emit()
						$WipeIncorrectSFX.play()
						index = 0
						break
					elif Globals.current_scene == $"../PatientRoom1/Front_door/Closed" || Globals.current_scene == $"../PatientRoom1/Front_door/Open":
						remove_point_front_door.emit()
						incorrect.emit()
						$WipeIncorrectSFX.play()
						index = 0
						break
					index += 1
				#if Globals.current_scene == $"../PatientRoom1/Front_door/Closed" || $"../PatientRoom1/Front_door/Open":
					#remove_point_front_door.emit()
					#incorrect.emit()
					#$WipeIncorrectSFX.play()
			elif area.get_name() == "Spray_area" && (str(item_held.texture.get_path().get_file()).contains("Cloth_wet_blue") || str(item_held.texture.get_path().get_file()).contains("Cloth_wet_red")): #Hit spray
				area.get_parent().queue_free()
				
	pass
	


func _on_area_exited(area: Area2D) -> void:
	curr_area = null

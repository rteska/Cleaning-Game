extends Node

signal spawn_chair_desk_close_bacteria
signal spawn_sink_bacteria
signal spawn_computer_screen_bacteria
signal spawn_light_switch_bacteria
signal spawn_front_door_bacteria
signal spawn_sharps_bin_bacteria
signal spawn_trash_bin_bacteria
signal spawn_desk_bacteria
signal spawn_computer_bacteria
signal spawn_chair_bed_bacteria
signal spawn_closet_bacteria
signal spawn_nightstand_above_bacteria
signal spawn_nightstand_below_bacteria
signal spawn_phone_bacteria
signal spawn_side_table_bacteria
signal spawn_nightstand_open_bacteria
signal spawn_rail_controls_bacteria
signal spawn_mirror_bacteria
signal spawn_shower_handle_bacteria
signal spawn_shower_head_bacteria
signal spawn_shower_curtain_railing_bacteria
signal spawn_soap_dispenser_bacteria
signal spawn_toilet_bacteria
signal spawn_bathroom_trash_bin_bacteria
signal spawn_pull_cord_bacteria
signal spawn_toilet_roll_bacteria
signal spawn_toilet_handle_bacteria
signal spawn_toilet_bar_bacteria
signal spawn_bathroom_door_handle_bacteria
signal spawn_bathroom_light_switch_bacteria

signal countdown_start

signal start_interim_cutscene
signal start_end_cutscene

@onready var inv: Inventory = preload("res://Inventory/main_inventory.tres")
var curr_scene = null

var already_called = false
var played_interim_cutscene = false
var played_end_cutscene = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.score >= 320 && !played_interim_cutscene:
		played_interim_cutscene = true
		$Canvas_inventory.visible = false
		$Score.visible = false
		$Interim_animation.visible = true
		Globals.current_scene.visible = false
		$PatientRoom1/Face_east.visible = true
		change_current_scene($PatientRoom1/Face_east)
		start_interim_cutscene.emit()
	
	if Input.is_action_just_pressed("cheat_button"):
		Globals.score = 320

#Starts the game
func start_game():
	$Room_transition_cooldown.start()
	$Canvas_inventory.visible = true
	$Score.visible = true
	$Player.visible = true
	$PatientRoom1.visible = true
	countdown_start.emit()
	$Countdown_timer.visible = true
	change_current_scene($PatientRoom1/Outside_room)

#Switches the scene from the outside door to inside the room
func _on_door_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Face_east)

#Switches the scene from facing east in the room to zooming in on the desk chair
func _on_chair_desk_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Chair_desk_close)

func _on_sink_interactable_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Sink)
		
func _on_door_to_bathroom_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Bathroom_entry)
		
func _on_computer_monitor_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Computer_screen)

func _on_front_light_switch_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Light_switch)

func _on_front_door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Front_door/Closed)

func _on_sharps_bin_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Sharps_bin)

func _on_trash_bin_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Trash_bin)

func _on_desk_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Desk)

func _on_computer_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Computer)

func _on_chair_bed_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Chair_bed)

func _on_closet_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Closet)

func _on_nightstand_above_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Nightstand_above)

func _on_nightstand_below_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Nightstand_below)

func _on_phone_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Phone)

func _on_nightstand_open_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Nightstand_open)

func _on_side_table_above_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Side_table_above)

func _on_rail_controls_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Rail_controls)

func _on_mirror_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Mirror)

func _on_soap_dispenser_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Soap_dispenser)

func _on_shower_curtain_rod_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Shower_curtain_railing)

func _on_shower_head_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Shower_head)

func _on_shower_handle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Shower_handle)

func _on_toilet_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Toilet)

func _on_bathroom_trash_bin_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Bathroom_trash_bin)

func _on_pull_cord_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Pull_cord)

func _on_toilet_roll_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Toilet_roll)

func _on_toilet_handle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Toilet_handle)

func _on_toilet_bar_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Toilet_bar)

func _on_bathroom_door_handle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Bathroom_door_handle/In)

func _on_bathroom_light_switch_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo():
		$Room_transition_cooldown.start()
		change_current_scene($PatientRoom1/Bathroom_light_switch)

func _on_cleaner_blue_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($PatientRoom1/Face_east/Cleaner_blue.item)

func _on_cleaner_blue_cloth_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($PatientRoom1/Face_east/Blue_cloth.item)

func _on_cleaner_red_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($PatientRoom1/Bathroom_east/cleaner_red.item)

func _on_red_cloth_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($PatientRoom1/Bathroom_east/red_cloth.item)

func change_current_scene(current_scene):
	curr_scene = current_scene
	Globals.current_scene = current_scene


func _on_room_transition_cooldown_timeout() -> void:
	
	if Globals.current_scene == $PatientRoom1/Outside_room: #Outside the room
		$PatientRoom1/Outside_room.visible = true
		$Canvas_inventory.visible = true
		$Start_page.visible = false
		$Background_sound.play()
		$Background_sound.volume_db = -15
	elif Globals.current_scene == $PatientRoom1/Face_east: #Initially entering the room facing east
		$PatientRoom1/Outside_room.visible = false
		$PatientRoom1/Face_east.visible = true
		$Background_sound.volume_db = -35
		$StepSound.play()
		$BackgroundMusic.play()
	elif Globals.current_scene == $PatientRoom1/Chair_desk_close: #Chair desk close
		$PatientRoom1/Face_east.visible = false
		$PatientRoom1/Chair_desk_close.visible = true
		$PatientRoom1/Chair_desk_close/Leave_chair_desk.visible = true
		spawn_chair_desk_close_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Sink: #Sink
		$PatientRoom1/Bathroom_east.visible = false
		$PatientRoom1/Sink.visible = true
		$PatientRoom1/Sink/Leave_sink.visible = true
		spawn_sink_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Bathroom_entry: #Bathroom entry
		$PatientRoom1/Face_south.visible = false
		$PatientRoom1/Bathroom_entry.visible = true
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Computer_screen: #Computer screen
		$PatientRoom1/Wall_east.visible = false
		$PatientRoom1/Computer_screen.visible = true
		spawn_computer_screen_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Light_switch: #Front door light switch
		$PatientRoom1/Face_west.visible = false
		$PatientRoom1/Light_switch.visible = true
		spawn_light_switch_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Front_door/Closed: #Front door 
		$PatientRoom1/Face_west.visible = false
		$PatientRoom1/Front_door.visible = true
		spawn_front_door_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Sharps_bin: #Sharps bin
		$PatientRoom1/Face_north.visible = false
		$PatientRoom1/Sharps_bin.visible = true
		spawn_sharps_bin_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Trash_bin: #Trash bin
		$PatientRoom1/Face_north.visible = false
		$PatientRoom1/Trash_bin.visible = true
		spawn_trash_bin_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Desk: #Desk
		$PatientRoom1/Face_north.visible = false
		$PatientRoom1/Desk.visible = true
		spawn_desk_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Computer: #Computer
		$PatientRoom1/Wall_east.visible = false
		$PatientRoom1/Computer.visible = true
		spawn_computer_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Chair_bed: #Chair near bed
		$PatientRoom1/Wall_east.visible = false
		$PatientRoom1/Chair_bed.visible = true
		spawn_chair_bed_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Closet: #Closet
		$PatientRoom1/Wall_north.visible = false
		$PatientRoom1/Closet.visible = true
		spawn_closet_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Nightstand_above: #Nightstand top
		$PatientRoom1/Wall_south.visible = false
		$PatientRoom1/Nightstand_above.visible = true
		spawn_nightstand_above_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Nightstand_below: #Nightstand bottom
		$PatientRoom1/Wall_south.visible = false
		$PatientRoom1/Nightstand_below.visible = true
		spawn_nightstand_below_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Phone: #Phone
		$PatientRoom1/Nightstand_above.visible = false
		$PatientRoom1/Phone.visible = true
		spawn_phone_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Nightstand_open: #N/A
		$PatientRoom1/Nightstand_above.visible = false
		$PatientRoom1/Nightstand_open.visible = true
		spawn_nightstand_open_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Side_table_above: #Rolling side table above
		$PatientRoom1/Wall_south.visible = false
		$PatientRoom1/Side_table_above.visible = true
		spawn_side_table_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Rail_controls: #Rail controls
		$PatientRoom1/Wall_south.visible = false
		$PatientRoom1/Rail_controls.visible = true
		spawn_rail_controls_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Mirror: #Mirror
		$PatientRoom1/Bathroom_east.visible = false
		$PatientRoom1/Mirror.visible = true
		spawn_mirror_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Soap_dispenser: #Soap dispenser
		$PatientRoom1/Bathroom_east.visible = false
		$PatientRoom1/Soap_dispenser.visible = true
		spawn_soap_dispenser_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Shower_handle: #Shower handle
		$PatientRoom1/Bathroom_east.visible = false
		$PatientRoom1/Shower_handle.visible = true
		spawn_shower_handle_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Shower_head: #Shower head
		$PatientRoom1/Bathroom_east.visible = false
		$PatientRoom1/Shower_head.visible = true
		spawn_shower_head_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Shower_curtain_railing: #Shower curtain railing and other railings
		$PatientRoom1/Bathroom_east.visible = false
		$PatientRoom1/Shower_curtain_railing.visible = true
		spawn_shower_curtain_railing_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Toilet: #Toilet
		$PatientRoom1/Bathroom_south.visible = false
		$PatientRoom1/Toilet.visible = true
		spawn_toilet_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Bathroom_trash_bin: #Bathroom trash bin
		$PatientRoom1/Bathroom_south.visible = false
		$PatientRoom1/Bathroom_trash_bin.visible = true
		spawn_bathroom_trash_bin_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Pull_cord: #Pull cord
		$PatientRoom1/Bathroom_south.visible = false
		$PatientRoom1/Pull_cord.visible = true
		spawn_pull_cord_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Toilet_roll: #Toilet roll
		$PatientRoom1/Bathroom_south.visible = false
		$PatientRoom1/Toilet_roll.visible = true
		spawn_toilet_roll_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Toilet_handle: #Toilet handle
		$PatientRoom1/Bathroom_south.visible = false
		$PatientRoom1/Toilet_handle.visible = true
		spawn_toilet_handle_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Toilet_bar: #Toilet bar
		$PatientRoom1/Bathroom_south.visible = false
		$PatientRoom1/Toilet_bar.visible = true
		spawn_toilet_bar_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Bathroom_door_handle/In: #Bathroom door inside
		$PatientRoom1/Bathroom_north.visible = false
		$PatientRoom1/Bathroom_door_handle.visible = true
		spawn_bathroom_door_handle_bacteria.emit()
		$StepSound.play()
	elif Globals.current_scene == $PatientRoom1/Bathroom_light_switch: #Bathroom light switch
		$PatientRoom1/Bathroom_north.visible = false
		$PatientRoom1/Bathroom_light_switch.visible = true
		spawn_bathroom_light_switch_bacteria.emit()
		$StepSound.play()
		
		
		


func _on_leave_button_end_game() -> void:
	start_end_cutscene.emit()
	$Canvas_inventory.visible = false
	$Player.visible = false
	$PatientRoom1.visible = false
	$End_animation.visible = true
	$Score.visible = false



func _on_interim_animation_return_visibility() -> void:
	$Canvas_inventory.visible = true
	$Leave_button.visible = true
	$Score.visible = true

func end_music():
	$BackgroundMusic.stop()
	$Background_sound.stop()
	$End_screen.visible = true

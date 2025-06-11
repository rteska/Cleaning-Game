extends Node

signal spawn_chair_desk_close_bacteria
signal spawn_sink_bacteria

@onready var inv: Inventory = preload("res://Inventory/main_inventory.tres")
var curr_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Starts the game
func start_game():
	$Outside_room.visible = true
	$Canvas_inventory.visible = true
	$Start_page.visible = false
	$Background_sound.play()
	$Background_sound.volume_db = -15
	change_current_scene($Outside_room)

#Switches the scene from the outside door to inside the room
func _on_door_interact_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact"):
		$Outside_room.visible = false
		$Face_east.visible = true
		$Background_sound.volume_db = -35
		change_current_scene($Face_east)
		$StepSound.play()
		$BackgroundMusic.play()

#Switches the scene from facing east in the room to zooming in on the desk chair
func _on_chair_desk_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact"):
		$Face_east.visible = false
		$Chair_desk_close.visible = true
		$Chair_desk_close/Leave_chair_desk.visible = true
		spawn_chair_desk_close_bacteria.emit()
		change_current_scene($Chair_desk_close)
		$StepSound.play()
	

func _on_sink_interactable_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact"):
		$Bathroom_east.visible = false
		$Sink.visible = true
		$Sink/Leave_sink.visible = true
		spawn_sink_bacteria.emit()
		change_current_scene($Sink)
		$StepSound.play()
	

func _on_door_to_bathroom_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$Face_south.hide()
		$Bathroom_entry.show()
		change_current_scene($Bathroom_entry)
		$StepSound.play()
	
	


func _on_cleaner_blue_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($Face_east/Cleaner_blue.item)

func _on_cleaner_blue_cloth_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($Face_east/Blue_cloth.item)

func _on_cleaner_red_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($Bathroom_east/cleaner_red.item)

func _on_red_cloth_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_action_pressed && event.button_index == MOUSE_BUTTON_LEFT && !event.is_echo()):
		inv.insert($Bathroom_east/red_cloth.item)

func change_current_scene(current_scene):
	curr_scene = current_scene
	Globals.current_scene = current_scene

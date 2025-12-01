extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bathroom_door_handle_hide_ultraviolet() -> void:
	$BathroomDoor.visible = false

func _on_bathroom_floor_hide_ultraviolet() -> void:
	$BathroomFloor.visible = false

func _on_bathroom_light_switch_hide_ultraviolet() -> void:
	$BathroomLightSwitch.visible = false

func _on_bathroom_trash_bin_hide_ultraviolet() -> void:
	$BathroomTrash.visible = false

func _on_chair_bed_hide_ultraviolet() -> void:
	$ChairBed.visible = false

func _on_chair_desk_close_hide_ultraviolet() -> void:
	$ChairDesk.visible = false

func _on_closet_hide_ultraviolet() -> void:
	$Closet.visible = false

func _on_computer_hide_ultraviolet() -> void:
	$Computer.visible = false

func _on_computer_screen_hide_ultraviolet() -> void:
	$ComputerScreen.visible = false

func _on_desk_hide_ultraviolet() -> void:
	$Desk.visible = false

func _on_front_door_hide_ultraviolet() -> void:
	$FrontDoor.visible = false

func _on_light_switch_hide_ultraviolet() -> void:
	$LightSwitch.visible = false

func _on_main_room_floor_1_hide_ultraviolet() -> void:
	$MainFloor1.visible = false

func _on_main_room_floor_2_hide_ultraviolet() -> void:
	$MainFloor2.visible = false

func _on_mirror_hide_ultraviolet() -> void:
	$Mirror.visible = false

func _on_nightstand_above_hide_ultraviolet() -> void:
	$NightstandAbove.visible = false

func _on_nightstand_below_hide_ultraviolet() -> void:
	$NightstandBelow.visible = false

func _on_phone_hide_ultraviolet() -> void:
	$Phone.visible = false

func _on_pull_cord_hide_ultraviolet() -> void:
	$PullCord.visible = false

func _on_rail_controls_hide_ultraviolet() -> void:
	$RemoteControls.visible = false

func _on_sharps_bin_hide_ultraviolet() -> void:
	$SharpsBin.visible = false

func _on_shower_curtain_railing_hide_ultraviolet() -> void:
	$ShowerBar.visible = false

func _on_shower_handle_hide_ultraviolet() -> void:
	$ShowerHandle.visible = false

func _on_shower_head_hide_ultraviolet() -> void:
	$ShowerHead.visible = false

func _on_side_table_above_hide_ultraviolet() -> void:
	$SideTable.visible = false

func _on_sink_hide_ultraviolet() -> void:
	$Sink.visible = false

func _on_soap_dispenser_hide_ultraviolet() -> void:
	$SoapDispenser.visible = false

func _on_toilet_hide_ultraviolet() -> void:
	$Toilet.visible = false

func _on_toilet_bar_hide_ultraviolet() -> void:
	$ToiletBar.visible = false

func _on_toilet_handle_hide_ultraviolet() -> void:
	$ToiletHandle.visible = false

func _on_toilet_roll_hide_ultraviolet() -> void:
	$PaperToiletRoll.visible = false

func _on_trash_bin_hide_ultraviolet() -> void:
	$TrashBin.visible = false

func reset_all():
	$Closet.visible = true
	$ComputerScreen.visible = true
	$Computer.visible = true
	$ChairBed.visible = true
	$ChairDesk.visible = true
	$Desk.visible = true
	$SharpsBin.visible = true
	$TrashBin.visible = true
	$SideTable.visible = true
	$RemoteControls.visible = true
	$NightstandBelow.visible = true
	$NightstandAbove.visible = true
	$Phone.visible = true
	$FrontDoor.visible = true
	$LightSwitch.visible = true
	$BathroomDoor.visible = true
	$BathroomLightSwitch.visible = true
	$Mirror.visible = true
	$Sink.visible = true
	$SoapDispenser.visible = true
	$ShowerBar.visible = true
	$ShowerHandle.visible = true
	$ShowerHead.visible = true
	$Toilet.visible = true
	$ToiletHandle.visible = true
	$BathroomTrash.visible = true
	$PullCord.visible = true
	$PaperToiletRoll.visible = true
	$ToiletBar.visible = true
	$MainFloor1.visible = true
	$MainFloor2.visible = true
	$BathroomFloor.visible = true
	
	
	

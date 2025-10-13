extends Node

@export var currentScene: Node
@export var nextScene: Node

signal hideBacteria
signal interim_cutscene
signal spawn_floor_bacteria
signal show_results

signal potential_add_room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# When arrow button is pressed, switch scenes and hide current one
func _on_button_pressed() -> void:
	$Cooldown.start()


func _on_cooldown_timeout() -> void:
	currentScene.visible = false
	nextScene.visible = true
	Globals.previous_scene = currentScene
	Globals.current_scene = nextScene
	$Footstep.play()
	hideBacteria.emit()
	spawn_floor_bacteria.emit()
	potential_add_room.emit()
	show_results.emit()
	
	
	if Globals.score >= 320:
		interim_cutscene.emit()

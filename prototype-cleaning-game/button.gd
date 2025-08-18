extends Node

@export var currentScene: Node
@export var nextScene: Node

signal hideBacteria

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
	Globals.current_scene = nextScene
	$Footstep.play()
	hideBacteria.emit()

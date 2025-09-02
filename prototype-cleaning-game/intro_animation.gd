extends Control

var index = 0
var count = 0

signal start_game
signal start_information_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_animation(): #Rolling in cart
	$ColorRect/fade_out.play("fade_transition")
	$RollingSFX.play()
	pass


func _on_fade_out_animation_finished(anim_name: StringName) -> void:
	index += 1
	
	if count < 5: #In the cutscene
		match count:
			0: #Washing hands
				$AnimatedSprite2D.set_frame(1)
				$RollingSFX.stop()
				$WaterTapSFX.play()
				$ColorRect/fade_out.play("fade_in_new")
				count += 1
			1: 
				$ColorRect/fade_out.play("fade_transition")
				count += 1
			2: #Putting up the wet floor sign
				$AnimatedSprite2D.set_frame(2)
				$WaterTapSFX.stop()
				$WetFloorSignSFX.play()
				$ColorRect/fade_out.play("fade_in_new")
				count += 1
			3:
				$ColorRect/fade_out.play("fade_transition")
				count += 1
			4: #Knocking on the door
				$KnockKnockSFX.play()
				$AnimatedSprite2D.set_frame(3)
				$ColorRect/fade_out.play("fade_in_new")
				count += 1
	else: #cutscene is done
		start_game.emit()
		start_information_button.emit()
		self.visible = false
	
	pass
	
	
	
	
	#$AnimatedSprite2D.frame(index)

extends Control

var index = 0
var count = 0


signal show_results

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_animation(): #Washing hands
	$ColorRect/Fade.play("fade_in")
	$OpenDoorSFX.play()
	pass


func _on_fade_animation_finished(anim_name: StringName) -> void:
	index += 1
	
	if count < 4:
		match count:
			0:
				$ColorRect/Fade.play("fade_out")
				count += 1
			1: #Opening the door to leave
				$AnimatedSprite2D.set_frame(1)
				$WashHandsSFX.play()
				$ColorRect/Fade.play("fade_in")
				count += 1
			2:
				$ColorRect/Fade.play("fade_out")
				count += 1
			3: #Results screen
				$RollingCartSFX.play()
				$AnimatedSprite2D.set_frame(2)
				$ColorRect/Fade.play("fade_in")
				count += 1
	else:
		self.visible = false
		show_results.emit()
	

func skip_animation():
	count = 4
	$ColorRect/Fade.stop()
	$WashHandsSFX.stop()
	$OpenDoorSFX.stop()
	$RollingCartSFX.stop()
	self.visible = false
	show_results.emit()

extends Control

var index = 0
var count = 0

signal return_visibility


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_animation(): #Washing hands
	$ColorRect/Fade.play("fade_in")
	$WashingHandsSFX.play()
	pass
	


func _on_fade_animation_finished(anim_name: StringName) -> void:
	index += 1
	
	if count < 6:
		match count:
			0:
				$ColorRect/Fade.play("fade_out")
				count += 1
			1: #Replacing toilet paper
				$AnimatedSprite2D.set_frame(1)
				$ToiletPaperReplaceSFX.play()
				$ColorRect/Fade.play("fade_in")
				count += 1
			2:
				$ColorRect/Fade.play("fade_out")
				count += 1
			3: #Replacing soap dispenser
				$AnimatedSprite2D.set_frame(2)
				$SoapDispenserReplaceSFX.play()
				$ColorRect/Fade.play("fade_in")
				count += 1
			4:
				$ColorRect/Fade.play("fade_out")
				count += 1
			5: #Put player back at the start
				$AnimatedSprite2D.set_frame(3)
				$ColorRect/Fade.play("fade_in")
				count += 1
	else:
		return_visibility.emit()
		self.visible = false
		

func skip_animation():
	count = 6
	$ColorRect/Fade.stop()
	$WashingHandsSFX.stop()
	$ToiletPaperReplaceSFX.stop()
	$SoapDispenserReplaceSFX.stop()
	return_visibility.emit()
	self.visible = false

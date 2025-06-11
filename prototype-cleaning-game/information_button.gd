extends ColorRect


var button_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Highlight.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_started():
	$Idle_timer.start()



func button_clicked():
	$Highlight/Highlight_animation.stop()
	#$Highlight/Highlight_animation.get_animation("repeat_fade").track_set_key_value(0)
	$Highlight.hide()
	button_pressed = true


func _on_idle_timer_timeout() -> void:
	if !button_pressed:
		$Highlight.show()
		$Highlight/Highlight_animation.play("repeat_fade")

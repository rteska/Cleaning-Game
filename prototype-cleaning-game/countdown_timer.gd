extends Control

var minutes
var seconds

signal countdown_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$Label.set_text(str($Timer.get_time_left()).pad_decimals(1))
	minutes = floor($Timer.time_left / 60)
	seconds = $Timer.time_left - (minutes * 60)
	$Label.text = "%02d : %02d" % [minutes, seconds]
	pass


func start_timer():
	$Timer.start()


func _on_timer_timeout() -> void:
	countdown_finished.emit()

func stop_timer():
	$Timer.stop()

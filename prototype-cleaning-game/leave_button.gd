extends Control

signal end_game
signal leave_room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TranslationServer.set_locale("en")
	$Button.text = tr("Leave_Button_Text")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	self.visible = false
	Globals.current_scene.visible = false
	leave_room.emit()
	end_game.emit()


func _on_start_page_translate(language: Variant) -> void:
	TranslationServer.set_locale(language)
	$Button.text = tr("Leave_Button_Text")

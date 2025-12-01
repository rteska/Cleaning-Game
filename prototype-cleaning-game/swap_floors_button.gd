extends Control

signal swap_floors

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TranslationServer.set_locale("en")
	$Button.text = tr("Swap_Floors_Button_Text")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	swap_floors.emit()


func _on_start_page_translate(language: Variant) -> void:
	TranslationServer.set_locale(language)
	$Button.text = tr("Swap_Floors_Button_Text")

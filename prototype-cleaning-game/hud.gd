extends CanvasLayer

signal start_game
signal translate(language)

var linksList = ["https://www.diverseybrands.com/product/Oxivir1OnestepReadytouseHospitalDisinfectantCleanerWipesMediumWipes60sipeseach12count",
"https://www.diverseybrands.com/product/CrewNASCSuperConcentrateNonAcidBowlBathroomDisinfectantCleaner14LSmartDose1count50192371"]

var language_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TranslationServer.set_locale("en")
	
	$Title.text = tr("Title")
	$Start.text = tr("Start_Button")
	$Difficulty.text = tr("Difficulty_Button")
	$Instructions.text = tr("Instructions_Button")
	$Back.text = tr("Back_Button")
	$Bodytext.text = tr("Body_Text")
	$Difficultytext.text = tr("Difficulty_Text")
	$HideBacteria.text = tr("Hide_Bacteria_Text")
	$LevelSelectBackground/LevelSelectScroll/LevelSelectHolder/LevelSelect/LinksLabel.text = tr("Links_text")
	
	$Bodytext.hide()
	$Difficultytext.hide()
	$Back.hide()
	$HideBacteria.hide()
	$LevelSelectBackground.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Swaps to the difficulty page on the title screen
func _on_difficulty_pressed() -> void:
	$Title.hide()
	$Start.hide()
	$Difficulty.hide()
	$Instructions.hide()
	$LanguageSelect.hide()
	
	$Difficultytext.show()
	$Back.show()
	$HideBacteria.show()
	

#Swap to instructions screen
func _on_instructions_pressed() -> void:
	$Title.hide()
	$Start.hide()
	$Difficulty.hide()
	$Instructions.hide()
	$LanguageSelect.hide()
	
	$Bodytext.show()
	$Back.show()

#Swap back to title screen
func _on_back_pressed() -> void:
	$Bodytext.hide()
	$Difficultytext.hide()
	$HideBacteria.hide()
	$Back.hide()
	
	$Title.show()
	$Start.show()
	$Difficulty.show()
	$Instructions.show()
	$LanguageSelect.show()

#Start game
func _on_start_pressed() -> void:
	$Title.hide()
	$Start.hide()
	$Difficulty.hide()
	$Instructions.hide()
	$Back.hide()
	$Sprite2D.hide()
	$LanguageSelect.hide()
	
	$LevelSelectBackground.show()


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	OS.shell_open(linksList[index])


func _on_level_select_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		start_game.emit()
		$TitleMusic.stop()
		$LevelSelectBackground.visible = false
		self.visible = false
		


func _on_hide_bacteria_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.difficulty_mode = true
	else:
		Globals.difficulty_mode = false
		


func _on_language_select_item_selected(index: int) -> void:
	language_selected = $LanguageSelect.text
	language_selected = language_selected.substr(language_selected.length() - 3, language_selected.length())
	language_selected = language_selected.left(-1)
	TranslationServer.set_locale(language_selected)
	Globals.language_selected = language_selected
	$Title.text = tr("Title")
	$Start.text = tr("Start_Button")
	$Difficulty.text = tr("Difficulty_Button")
	$Instructions.text = tr("Instructions_Button")
	$Back.text = tr("Back_Button")
	$Bodytext.text = tr("Body_Text")
	$Difficultytext.text = tr("Difficulty_Text")
	$HideBacteria.text = tr("Hide_Bacteria_Text")
	$LevelSelectBackground/LevelSelectScroll/LevelSelectHolder/LevelSelect/LinksLabel.text = tr("Links_text")
	translate.emit(language_selected)

func start_music():
	$TitleMusic.play()
	$Title.show()
	$Start.show()
	$Difficulty.show()
	$Instructions.show()
	$LanguageSelect.show()
	

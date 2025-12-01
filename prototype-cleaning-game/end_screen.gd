extends Control

var string_to_replace = "_"

var counter = 0
var positive_count = 0
var negative_count = 0
var player_score = 0
var total_score = 0

signal stop_music
signal restart_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_results():
	#$MarginContainer/HBoxContainer/Results1.text = str(Globals.correct_rooms_order[0].name) + " " + str(Globals.rooms_points[0][0]) + "/" + str(Globals.rooms_points[0][1]) + "; Correct Order: "
	#if Globals.rooms_truly_missed[0] == 1:
		#$MarginContainer/HBoxContainer/Results1.text += "Yes\n"
	#else:
		#$MarginContainer/HBoxContainer/Results1.text += "No\n"
	
	#Calculate total score
	for i in Globals.rooms_points.size():
		player_score += Globals.rooms_points[i][0]
		total_score += Globals.rooms_points[i][1]
		
	
	#Display total score
	$TotalScore/HBoxContainer/Label.text = "Total score: " + str(player_score) + "/" + str(total_score)
	
	
	
	for i in range(17): #Show results for areas 0-16
		if str(Globals.correct_rooms_order[i].name) == "Closed":
			$MarginContainer/HBoxContainer/Results1.text += "Front door closed:" + " " + str(Globals.rooms_points[i][0]) + "/" + str(Globals.rooms_points[i][1]) + "; Correct Order:"
		elif str(Globals.correct_rooms_order[i].name) == "Open":
			$MarginContainer/HBoxContainer/Results1.text += "Front door open:" + " " + str(Globals.rooms_points[i][0]) + "/" + str(Globals.rooms_points[i][1]) + "; Correct Order:"
		elif str(Globals.correct_rooms_order[i].name) == "In":
			$MarginContainer/HBoxContainer/Results1.text += "Bathroom door in:" + " " + str(Globals.rooms_points[i][0]) + "/" + str(Globals.rooms_points[i][1]) + "; Correct Order:"
		else:
			$MarginContainer/HBoxContainer/Results1.text += str(Globals.correct_rooms_order[i].name).replace(string_to_replace, " ") + ": " + str(Globals.rooms_points[i][0]) + "/" + str(Globals.rooms_points[i][1]) + "; Correct Order:"
		
		if Globals.rooms_truly_missed[i] == 1:
			$MarginContainer/HBoxContainer/Results1.text += " Yes\n"
		else:
			$MarginContainer/HBoxContainer/Results1.text += " No\n"
		
		
	for i in range(17, 34): #Show results for 17-33
		if str(Globals.correct_rooms_order[i].name) == "Out":
			$MarginContainer/HBoxContainer/Results2.text += "Bathroom door out:" + " " + str(Globals.rooms_points[i][0]) + "/" + str(Globals.rooms_points[i][1]) + "; Correct Order:"
		else:
			$MarginContainer/HBoxContainer/Results2.text += str(Globals.correct_rooms_order[i].name).replace(string_to_replace, " ") + ": " + str(Globals.rooms_points[i][0]) + "/" + str(Globals.rooms_points[i][1]) + "; Correct Order:"
		
		if Globals.rooms_truly_missed[i] == 1:
			$MarginContainer/HBoxContainer/Results2.text += " Yes\n"
		else:
			$MarginContainer/HBoxContainer/Results2.text += " No\n"

func show_second_results():
	stop_music.emit()
	#See if there needs to be a comment about the amount of rooms missed
	for i in Globals.rooms_missed.size():
		counter += 1
		if counter > 15:
			$Details_results/HBoxContainer/Label.text += "Looks like you missed a few areas. Be thorough.\n"
			negative_count += 1
			break
			
	if counter <= 15:
		$Details_results/HBoxContainer/Label.text += "You were very thorough with finding areas to clean. Great job!\n"
		positive_count += 1
	
	counter = 0
	
	#See if there needs to be a comment about the amount of bugs missed
	for i in Globals.rooms_points.size():
		if Globals.rooms_points[i][0] < Globals.rooms_points[i][1]:
			counter += 1
		if counter > 20:
			$Details_results/HBoxContainer/Label.text += "Looks like you missed some bugs. Clean every inch of surface you see.\n"
			negative_count += 1
			break
			
	
	if counter <= 20:
		$Details_results/HBoxContainer/Label.text += "You cleaned very thoroughly within the areas. Nice!\n"
		positive_count += 1
	
	counter = 0
	
	#Check how many areas they did out of order
	for i in Globals.rooms_truly_missed.size():
		if Globals.rooms_truly_missed[i] == 0:
			counter += 1
	
	if counter > 17:
		$Details_results/HBoxContainer/Label.text += "Some areas were done out of order. Review your sources as to what order you need to clean places in.\n"
		negative_count += 1
	else:
		$Details_results/HBoxContainer/Label.text += "You did a lot of the areas in order. Solid work!\n"
		positive_count += 1
	
	#Final video results
	if negative_count > positive_count:
		$Details_results/HBoxContainer/Label.text += "Maybe this informational video can help.\n"
		#$Details_results/Informational_video.play()
	else:
		$Details_results/HBoxContainer/Label.text += "Have this fun video!\n"
		#$Details_results/Good_video.play()
		
	


func _on_restart_button_restart_game() -> void:
	$TotalScore.visible = true
	$Details_results.visible = false
	$Credits_label.visible = false
	$TotalScore/HBoxContainer/Label.text = ""
	$MarginContainer/HBoxContainer/Results1.text = ""
	$MarginContainer/HBoxContainer/Results2.text = ""
	$Details_results/HBoxContainer/Label.text = ""
	restart_game.emit()


func _on_next_page_spawn_floor_bacteria() -> void:
	$Credits_label.visible = true

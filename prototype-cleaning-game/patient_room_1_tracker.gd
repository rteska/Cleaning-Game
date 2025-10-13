extends Node2D

var correct_rooms_order #34 rooms
var rooms_cleaned = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] 
var rooms_points = [[0, 5], [0, 5], [0, 7], [0, 15], [0, 15], [0, 10], [0, 30], [0, 5], [0, 22], [0, 5], [0, 30], [0, 10], [0, 15], [0, 16], [0, 40], [0, 10], [0, 10], [0, 10], [0, 10], [0, 5], [0, 22], [0, 15], [0, 15], [0, 19], [0, 5], [0, 10], [0, 15], [0, 10], [0, 15], [0, 5], [0, 20], [0, 35], [0, 15], [0, 35]]
var order_rooms_traversed = []
var rooms_missing = []
var rooms_incorrect = []
var rooms_truly_incorrect = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

var found_room = false
var found_room_2 = false

var test = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	correct_rooms_order = [$"../Front_door/Closed", $"../Front_door/Open", $"../Light_switch", $"../Trash_bin", $"../Sharps_bin", $"../Desk", 
$"../Chair_desk_close", $"../Closet", $"../Computer_screen", $"../Computer", $"../Chair_bed", $"../Nightstand_above", $"../Phone", $"../Nightstand_below", 
$"../Side_table_above", $"../Rail_controls", $"../Bathroom_door_handle/In", $"../Bathroom_door_handle/Out", $"../Bathroom_light_switch", 
$"../Mirror", $"../Sink", $"../Soap_dispenser", $"../Shower_handle", $"../Shower_curtain_railing", $"../Shower_head",  
$"../Toilet_handle", $"../Pull_cord", $"../Toilet_roll", $"../Toilet_bar",
$"../Bathroom_trash_bin",  $"../Toilet", $"../Main_room_floor1", $"../Main_room_floor2", $"../Bathroom_floor"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Add room to rooms traversed list
func add_room():
	if Globals.current_scene != $"../Outside_room" && Globals.current_scene != $"../Face_east" && Globals.current_scene != $"../Wall_east" && Globals.current_scene != $"../Wall_south" && Globals.current_scene != $"../Wall_north" && Globals.current_scene != $"../Face_west" && Globals.current_scene != $"../Face_north" && Globals.current_scene != $"../Face_south" && Globals.current_scene != $"../Bathroom_entry" && Globals.current_scene != $"../Bathroom_east" && Globals.current_scene != $"../Bathroom_south" && Globals.current_scene != $"../Bathroom_north":
		for room in order_rooms_traversed: #Check if the room has already been added
			if room == Globals.current_scene:
				found_room = true
				break
		
		if !found_room: #Add the room
			order_rooms_traversed.append(Globals.current_scene)
	found_room = false

#Compare lists for correct cleaning order and no missing rooms
func compare_lists():
	for i in correct_rooms_order.size(): #In the entire rooms list
		if i < order_rooms_traversed.size():
			if correct_rooms_order[i] != order_rooms_traversed[i]: #Check if the order is correct
				rooms_incorrect.append(order_rooms_traversed[i]) #If not, append it to a tracking list
		for j in order_rooms_traversed.size(): #In the rooms traversed list
			if correct_rooms_order[i] == order_rooms_traversed[j]: #If the current rooms list item matches somewhere in the traversed rooms list
				found_room_2 = true #Then the player at least went there
				break
		if !found_room_2: #If the room is not found in rooms traversed list
			rooms_missing.append(correct_rooms_order[i]) #Then append it to another tracking list
		found_room_2 = false
	
	for i in correct_rooms_order.size(): #Compare rooms traversed to the correct order
		if i < order_rooms_traversed.size():
			if correct_rooms_order[i] == order_rooms_traversed[i]: #For every correct one
				rooms_truly_incorrect[i] = 1 #Change the tracking to yes
	
	
	#Testing purposes
	print("Rooms incorrect")
	for room in rooms_incorrect:
		print(room)
	print("")
	print("Order of rooms traversed")
	for room in order_rooms_traversed:
		print(room)
	print("")
	print("Rooms missing")
	for room in rooms_missing:
		print(room)
	pass_order_rooms_traversed()
	pass_rooms_missed()
	pass_rooms_points()
	pass_correct_rooms_order()
	pass_truly_incorrect()

#Update list to reflect room cleaned
func room_cleaned():
	for i in correct_rooms_order.size():
		if Globals.previous_scene == $"../Front_door":
			rooms_cleaned[0] = 1
			rooms_cleaned[1] = 1
		elif Globals.previous_scene == $"../Bathroom_door_handle":
			rooms_cleaned[16] = 1
			rooms_cleaned[17] = 1
		elif correct_rooms_order[i] == Globals.previous_scene: #Find the scene
			rooms_cleaned[i] = 1 #0 for not cleanded, 1 for cleaned
			break
	#for check in rooms_cleaned:
		#print(check)

func record_points(points: int, total_points: int, in_score: int, out_score: int):
	var index = -1
	
	for scene in correct_rooms_order: #Find the index of the scene
		index += 1
		if Globals.previous_scene == $"../Front_door":
			rooms_points[0][0] = in_score
			rooms_points[0][1] = 5
			rooms_points[1][0] = out_score
			rooms_points[1][1] = 5
			break
		elif Globals.previous_scene == $"../Bathroom_door_handle":
			rooms_points[16][0] = in_score
			rooms_points[16][1] = 10
			rooms_points[17][0] = out_score
			rooms_points[17][1] = 10
			break
		elif scene == Globals.previous_scene:
			rooms_points[index][0] = points
			rooms_points[index][1] = total_points
			break
	
	
	print(rooms_points[index])
	


func pass_order_rooms_traversed():
	Globals.rooms_traversed = order_rooms_traversed

func pass_rooms_missed():
	Globals.rooms_missed = rooms_missing
	
func pass_rooms_points():
	Globals.rooms_points = rooms_points

func pass_correct_rooms_order():
	Globals.correct_rooms_order = correct_rooms_order
	
func pass_truly_incorrect():
	Globals.rooms_truly_missed = rooms_truly_incorrect

class_name Bottlemino extends Control

const Bottle = preload("res://scenes/bottle/bottle.tscn")
const Keg = preload("res://scenes/keg/keg.tscn")

var keg: Keg
var selected_bottle: Bottle = null
var turn_counter: int = 8
var bottle_list = []

onready var space_width = get_viewport_rect().size.x / float(AutoLoad.board_columns)
onready var space_height = get_viewport_rect().size.y / ceil(AutoLoad.bottle_quantity / float(AutoLoad.board_columns))
onready var space_size = Vector2(space_width, space_height)


func _ready():
	keg = Keg.instance()
	add_child(keg)
	
	for bottle in AutoLoad.bottle_quantity:
		var new_bottle = Bottle.instance()
		
		self.add_child(new_bottle)
		bottle_list.push_back(new_bottle)
		new_bottle.position = space_size * grid_position(bottle_list.size(), AutoLoad.board_columns) - (space_size / 2)
		
	for bottle in bottle_list:
		keg.pour(bottle)


func grid_position(position, row_length):
	var column = fmod(position - 1, row_length) + 1
	var row = floor((position - 1) / row_length) + 1
	var coordinate: Vector2 = Vector2(column, row)
	
	return coordinate


func check_bottle_states():
	for bottle in bottle_list:
		if not bottle.paused:
			if bottle.full():
				if not bottle.mixed():
					bottle.complete()


func _on_Bottle_selected(bottle: Bottle):
		if selected_bottle == null:
			selected_bottle = bottle.select()
		elif selected_bottle == bottle:
			selected_bottle = bottle.deselect()
		else:
			if selected_bottle.pour(bottle):
				check_bottle_states()
				var turn_label = get_node("/root/Game/TopBar/InfoBar/TurnsLeftLabel")
				if turn_label.text == "0":
					for bottle in bottle_list:
						if not keg.pour(bottle):
							if bottle.mixed():
								bottle.terminate()
					turn_label.text = "8"
				else:
					turn_label.text = String(int(turn_label.text) - 1)


func _on_Bottle_terminated(bottle: Bottle):
	bottle_list.erase(bottle)
	if bottle == selected_bottle:
		selected_bottle = selected_bottle.deselect()
		selected_bottle = null


func _on_Bottle_completed(_bottle: Bottle):
	var score_label = get_node("/root/Game/TopBar/InfoBar/ScoreLabel")
	score_label.text = String(int(score_label.text) + 1)


func _on_PourButton_pressed():
	var turn_label = get_node("/root/Game/TopBar/InfoBar/TurnsLeftLabel")
	turn_label.text = "8"
	for bottle in bottle_list:
		if not keg.pour(bottle):
			if bottle.mixed():
				bottle.terminate()

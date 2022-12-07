class_name Zen extends Control

const Bottle = preload("res://scenes/bottle/bottle.tscn")
const Keg = preload("res://scenes/keg/keg.tscn")

var keg: Keg

var selected_bottle: Bottle = null
var game_mode

var turn_counter: int = 8

enum mode{
	NORMAL,
	ZEN,
	BOTTLEMINO,
}

var bottle_list = []

onready var space_width = get_viewport_rect().size.x / float(AutoLoad.board_columns)
onready var space_height = get_viewport_rect().size.y / ceil(AutoLoad.bottle_quantity / float(AutoLoad.board_columns))
onready var space_size = Vector2(space_width, space_height)


func _ready():
	game_mode = AutoLoad.game_mode
	keg = Keg.instance()
	add_child(keg)
	
	for bottle in AutoLoad.bottle_quantity:
		var new_bottle = Bottle.instance()
		
		self.add_child(new_bottle)
		bottle_list.push_back(new_bottle)
		new_bottle.position = space_size * grid_position(bottle_list.size(), AutoLoad.board_columns) - (space_size / 2)
		
	for bottle in bottle_list:
		while bottle.volume() < AutoLoad.bottle_initial_level:
			keg.pour(bottle)


func _process(_delta):
	for bottle in bottle_list:
		if not bottle.paused:
			if bottle.full():
				if not bottle.mixed():
					bottle.complete()


func grid_position(position, row_length):
	var column = fmod(position - 1, row_length) + 1
	var row = floor((position - 1) / row_length) + 1
	var coordinate: Vector2 = Vector2(column, row)
	
	return coordinate


func _on_Bottle_selected(bottle: Bottle):
		if selected_bottle == null:
			selected_bottle = bottle.select()
		elif selected_bottle == bottle:
			selected_bottle = bottle.deselect()
		else:
			selected_bottle.pour(bottle)


func _on_Bottle_terminated(bottle: Bottle):
	bottle_list.erase(bottle)
	if bottle == selected_bottle:
		selected_bottle = selected_bottle.deselect()
		selected_bottle = null


func _on_Bottle_completed(bottle: Bottle):
	while bottle.volume() < bottle.capacity:
		keg.pour(bottle)

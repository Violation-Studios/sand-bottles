class_name Game extends Node2D

const Bottle = preload("res://scenes/bottle/bottle.tscn")
const Section = preload("res://scenes/bottle/section/section.tscn")

var colors = [
	Color("#0d2b45"), Color("#203c56"), Color("#544e68"), Color("#8d697a"),
	Color("#d08159"), Color("#ffaa5e"), Color("#ffd4a3"), Color("#ffecd6"),
]
var selected_bottle: Bottle = null
const bottle_quantity: int = 9
const bottle_fill_amount: int = 8
const bottle_capacity: int = 9
const color_quantity:int = 8
const board_columns: int = 3


func _ready():
	var grid_list = create_grid_list(bottle_quantity, board_columns)
	var bottle_list = create_bottle_list_from(grid_list)
	var color_list = create_color_list(bottle_list.size(), bottle_fill_amount)
	var section_list = create_section_list(color_list)
	var _filled_list = fill_bottles_from(section_list, bottle_list, bottle_fill_amount)


func fill_bottles_from(section_list: Array, bottle_list: Array, fill_amount: int):
	var filled_list = []
	
	var fill_index = 1
	var bottle_index = 0
	var section_index = 0
	while section_index < section_list.size():
		if fill_index > fill_amount:
			fill_index = 1
			bottle_index += 1
		
		bottle_list[bottle_index].add_child(section_list[section_index])
		bottle_list[bottle_index].sections.push_back(section_list[section_index])
		
		section_list[section_index].scale.y /= bottle_capacity
		section_list[section_index].position.y = position_section_at(fill_index - 1)
		
		fill_index += 1
		if fill_index > fill_amount:
			filled_list.push_back(bottle_list[bottle_index])
			
		section_index += 1
	
	return filled_list


func create_section_list(color_list: Array):
	var section_list = []
	
	for color in color_list:
		var new_section = Section.instance()
		new_section.color = color
		section_list.push_back(new_section)
	
	return section_list


func create_color_list(_bottle_quantity: int, fill_amount: int):
	var color_list = []
	var color_slice = colors.slice(0,fill_amount - 1,1)
	
	for i in color_quantity + 1:
		color_list += color_slice
		
	randomize()
	color_list.shuffle()
	
	return color_list


func position_section_at(location):
	return (-120.0 / bottle_capacity) * (1 + (location * 2)) +120


func create_bottle_list_from(list: Array):
	var bottle_list = []
	var space_width = get_viewport_rect().size.x / float(board_columns)
	var space_height = get_viewport_rect().size.y / ceil(bottle_quantity / float(board_columns))
	var space_size = Vector2(space_width, space_height)
	var bottle_scale_multiplier = 1.0 / sqrt(sqrt(bottle_quantity) * board_columns)
	
	for location in list:
		var new_bottle = Bottle.instance()
	
		add_child(new_bottle)
		new_bottle.scale *= bottle_scale_multiplier
		new_bottle.position = space_size * location - (space_size / 2)
		
		new_bottle.connect("selected", self, "_on_Bottle_selected")
		bottle_list.push_back(new_bottle)
	
	return bottle_list


func create_grid_list(number_of_spaces, number_of_columns):
	var grid_list = []
	
	var row_index = 1
	var column_index = 1
	var spaces_to_generate = number_of_spaces
	while spaces_to_generate > 0:
		if column_index > number_of_columns:
			column_index = 1
			row_index += 1
		
		grid_list.push_back(Vector2(column_index, row_index))
		spaces_to_generate -= 1
		column_index += 1
	
	return grid_list


func try_move_section(from: Bottle, to: Bottle):
	if from.sections.size() > 0 and to.sections.size() < bottle_capacity:
		from.remove_child(from.sections.back())
		to.add_child(from.sections.back())
		
		to.sections.push_back(from.sections.pop_back())
		
		to.sections[-1].position.y = position_section_at(to.sections.size() - 1)


func _on_Bottle_selected(bottle):
		if selected_bottle == null:
			selected_bottle = bottle
			selected_bottle.rotation = PI/8
		elif selected_bottle == bottle:
			selected_bottle.rotation = 0
			selected_bottle = null
		else:
			try_move_section(selected_bottle, bottle)

extends Node2D

var Bottle = preload("res://scenes/bottle/bottle.tscn")
var Section = preload("res://scenes/bottle/section/section.tscn")

var colors = [
	Color("#0d2b45"), Color("#203c56"), Color("#544e68"), Color("#8d697a"),
	Color("#d08159"), Color("#ffaa5e"), Color("#ffd4a3"), Color("#ffecd6"),
]
var bottles = []
var selected_bottle: Bottle = null
var section_quantity: int = 5


func _ready():
	setup_board(4,3)
	for section in bottles[0].sections:
		section.queue_free()
	bottles[0].sections.clear()


func _process(_delta):
	pass


func create_bottle(color_quantity: int):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var new_bottle = Bottle.instance()
	
	add_child(new_bottle)
	new_bottle.connect("selected", self, "_on_Bottle_selected")
	bottles.push_back(new_bottle)
	
	for section in section_quantity:
		var picked_color = rng.randi_range(0, color_quantity - 1)
	
		var new_section = Section.instance()
		new_section.color = colors[picked_color]
		new_bottle.sections.push_back(new_section)
		new_bottle.add_child(new_section)
		
		new_section.scale.y /= section_quantity
		position_section(new_section, section)
	
	return new_bottle


func position_section(section, position):
	section.position.y = (-120.0 / section_quantity) * (1 + (position * 2)) +120


func setup_board(rows: int, columns: int):
	var column_width = get_viewport_rect().size.x / columns
	var row_height = get_viewport_rect().size.y / rows
	
	for row in range(1, rows + 1):
		for column in range(1, columns + 1):
			var bottle = create_bottle(5)
			bottle.position.x = column_width * column - (column_width / 2)
			bottle.position.y = row_height * row - (row_height / 2)


func try_move_section(from, to):
	if from.sections.size() > 0 and to.sections.size() < section_quantity:
		from.remove_child(from.sections.back())
		to.add_child(from.sections.back())
		
		to.sections.push_back(from.sections.pop_back())
		
		position_section(to.sections.back(), to.sections.size() - 1)


func _on_Bottle_selected(bottle):
		if selected_bottle == null:
			selected_bottle = bottle
			selected_bottle.rotation = PI/8
		elif selected_bottle == bottle:
			selected_bottle.rotation = 0
			selected_bottle = null
		else:
			try_move_section(selected_bottle, bottle)

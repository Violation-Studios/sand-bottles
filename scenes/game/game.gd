extends Node2D

var Bottle = preload("res://scenes/bottle/bottle.tscn")
var Section = preload("res://scenes/bottle/section/section.tscn")

var bottles = []
var selected_bottles = []


func _ready():
	setup_board(6,4)


func _process(_delta):
	for bottle in selected_bottles:
		if bottle.rotation >= TAU:
			bottle.rotation = 0.0
		bottle.rotation += 0.01


func create_bottle(section_quantity: int, _color_quantity: int):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var new_bottle = Bottle.instance()
	
	add_child(new_bottle)
	new_bottle.connect("selected", self, "_on_Bottle_selected")
	bottles.push_back(new_bottle)
	
	for section in section_quantity:
		var red_value = rng.randf_range(0,1)
		var green_value = rng.randf_range(0,1)
		var blue_value = rng.randf_range(0,1)
	
		var new_section = Section.instance()
		new_section.color = Color(red_value, green_value, blue_value, 1)
		new_bottle.sections.push_back(new_section)
		new_bottle.add_child(new_section)
		
		print(new_section.color)
	
	return new_bottle


func setup_board(rows: int, columns: int):
	var column_width = get_viewport_rect().size.x / columns
	var row_height = get_viewport_rect().size.y / rows
	
	for row in range(1, rows + 1):
		for column in range(1, columns + 1):
			var bottle = create_bottle(1,1)
			bottle.position.x = column_width * column - (column_width / 2)
			bottle.position.y = row_height * row - (row_height / 2)
			
			print(Vector2(row,column), " - ", bottle.position)


func _on_Bottle_selected(bottle):
		selected_bottles.push_back(bottle)
		print(bottle.position)

extends Node2D

var Bottle = preload("res://scenes/bottle/bottle.tscn")

var bottles = []
var selected_bottles = []
var board_size = Vector2(4,4)


func _ready():
	start_game(16,1,1,board_size)


func _process(delta):
	for bottle in selected_bottles:
		bottle.rotation += 0.01


func start_game(bottle_quantity:int, color_quantity:int, part_quantity:int, grid_size:Vector2):
	for bottle in bottle_quantity:
		var new_bottle = Bottle.instance()
		add_child(new_bottle)
		new_bottle.connect("selected", self, "_on_Bottle_selected")
		bottles.push_back(new_bottle)
		
	for row in range(1, grid_size.y + 1):
		for column in range(1, grid_size.x + 1):
			print(Vector2(row,column))
			bottles[column * row - 1].position.x = 192 * column
			bottles[column * row - 1].position.y = 384 * row
			print(bottles[column * row - 1].position)

func _on_Bottle_selected(bottle):
		selected_bottles.push_back(bottle)

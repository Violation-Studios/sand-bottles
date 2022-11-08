extends Node2D

var Bottle = preload("res://scenes/bottle/bottle.tscn")

var bottles = []
var selected_bottles = []


func _ready():
	start_game(1,1,1)


func _process(delta):
	for bottle in selected_bottles:
		bottle.rotation += 1.0


func start_game(number_of_bottles, number_of_colors, number_of_parts):
	for bottle in number_of_bottles:
		var new_bottle = Bottle.instance()
		add_child(new_bottle)
		bottles.push_back(new_bottle)


func _on_Bottle_selected(bottle):
	if selected_bottles.size() == 0:
		selected_bottles.push_back(bottle)

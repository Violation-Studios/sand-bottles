class_name Keg extends Node

const Section = preload("res://scenes/bottle/section/section.tscn")

var sections = []


func _ready():
	self.fill()


func fill():
	var color_list = []
	var color_slice = AutoLoad.colors.slice(0,AutoLoad.bottle_initial_level - 1,1)
	
	for i in AutoLoad.bottle_quantity:
		color_list += color_slice
		
	randomize()
	color_list.shuffle()
	
	
	for color in color_list:
		var section = Section.instance()
		
		section.paint(color)
		sections.push_back(section)

func pour(bottle: Bottle):
	var transfer_success: bool = false
	var section: Section
	
	if not sections.empty():
		section = sections.back()
		transfer_success = bottle.fill(section)
	elif sections.empty():
		self.fill()
	
	if transfer_success == true:
		sections.erase(section)
	
	return transfer_success

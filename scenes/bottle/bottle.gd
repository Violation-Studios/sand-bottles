class_name Bottle extends Polygon2D

var paused: bool = false

var sections = []
var capacity: int = AutoLoad.bottle_capacity
var initial_level: int = AutoLoad.bottle_initial_level
var fill_level: int

signal selected(bottle)
signal terminated(bottle)
signal completed(bottle)


func _ready():
	match AutoLoad.game_mode:
		AutoLoad.mode.BOTTLEMINO:
			fill_level = capacity
		AutoLoad.mode.NORMAL, AutoLoad.mode.ZEN:
			fill_level = initial_level
	
	var bottle_scale_multiplier = 1.0 / sqrt(sqrt(AutoLoad.bottle_quantity) * AutoLoad.board_columns)
	
	self.scale *= bottle_scale_multiplier
	
# warning-ignore:return_value_discarded
	self.connect("selected", get_parent(), "_on_Bottle_selected")
# warning-ignore:return_value_discarded
	self.connect("terminated", get_parent(), "_on_Bottle_terminated")
# warning-ignore:return_value_discarded
	self.connect("completed", get_parent(), "_on_Bottle_completed")

func _process(_delta):
	if paused:
		return

	if full():
		match AutoLoad.game_mode:
			AutoLoad.mode.BOTTLEMINO:
				if mixed():
					terminate()
				elif not mixed():
					complete()
			AutoLoad.mode.NORMAL:
				if not mixed():
					terminate()
			AutoLoad.mode.ZEN:
				if not mixed():
					complete()
					pass


func terminate():
	paused = true
	$Area2D/CollisionPolygon2D.disabled = true
	emit_signal("terminated", self)


func complete():
	empty()
	emit_signal("completed", self)


func fill(section: Section):
	var transfer_success: bool = false
	var full: bool = sections.size() >= fill_level

	if not full:
		self.add_child(section)
		
		sections.push_back(section)
		section.place(sections.size())
		
		transfer_success = true
	elif full:
		fill_level = capacity
	
	return transfer_success


func pour(bottle: Bottle):
	var transfer_success: bool = false
	
	if not self.sections.empty():
		var section = sections.back()
		self.remove_child(section)
		
		if bottle.fill(section):
			self.sections.pop_back()
			transfer_success = true
		else:
			self.add_child(section)
	
	return transfer_success


func mixed():
	var mixed: bool = false
	
	for section in sections:
		if section.color != sections.front().color:
			mixed = true
			break
			
	return mixed


func select():
	self.rotation = PI/8
	return self


func deselect():
	self.rotation = 0
	return null


func empty():
	for child in self.get_children():
		if child is Polygon2D:
			child.queue_free()
	sections.clear()


func full():
	return sections.size() == capacity


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("selected", self)

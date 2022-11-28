class_name Bottle extends Node2D

var sections = []

signal selected(bottle)


func is_bottle_unmixed():
	var bottle_is_unmixed: bool = true
	
	for section in sections:
		if section.color != sections.front().color:
			bottle_is_unmixed = false
			break
	
	return bottle_is_unmixed


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("selected", self)

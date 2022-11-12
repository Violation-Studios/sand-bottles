class_name Bottle extends Node2D

var sections = []

signal selected(bottle)


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("selected", self)

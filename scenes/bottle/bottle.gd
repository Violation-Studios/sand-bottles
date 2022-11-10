extends Node2D

signal selected(bottle)

onready var BOTTLE_SIZE: Vector2 = $Area2D/CollisionPolygon2D.shape.extents * 2

func _ready():
	pass


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("selected", self)

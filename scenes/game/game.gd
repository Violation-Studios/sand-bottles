extends Control

func _ready():
	var scene
	match AutoLoad.game_mode:
		AutoLoad.mode.NORMAL:
			scene = load("res://scenes/game-boards/normal/normal.tscn")
		AutoLoad.mode.ZEN:
			scene = load("res://scenes/game-boards/zen/zen.tscn")
		AutoLoad.mode.BOTTLEMINO:
			scene = load("res://scenes/game-boards/bottlemino/bottlemino.tscn")
			
	scene = scene.instance()
	add_child(scene)

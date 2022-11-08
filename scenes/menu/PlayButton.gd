extends Button

var game_scene = preload("res://scenes/game/game.tscn")

func _on_PlayButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(game_scene)

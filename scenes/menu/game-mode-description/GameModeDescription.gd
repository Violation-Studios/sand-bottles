extends PanelContainer


func _ready():
	match AutoLoad.game_mode:
		AutoLoad.mode.NORMAL:
			$VBoxContainer/Title.text = "normal"
			$VBoxContainer/Description.text = "Move pieces from bottle to bottle to unmix the bottles. Unmix all the bottles to win."
		AutoLoad.mode.ZEN:
			$VBoxContainer/Title.text = "zen"
			$VBoxContainer/Description.text = "Move pieces from bottle to bottle to unmix the bottles. Unmix as many bottles as you want in this infinite game mode."
		AutoLoad.mode.BOTTLEMINO:
			$VBoxContainer/Title.text = "bottlemino"
			$VBoxContainer/Description.text = "Move pieces from bottle to bottle to unmix the bottles. If a mixed bottle fills up it is removed from play. If a bottle is filled with a single color it is emptied and you score a point. The bottles fill every eight moves. Try for a highscore"


func _on_GameModeList_item_selected(index):
	match index:
		AutoLoad.mode.NORMAL:
			$VBoxContainer/Title.text = "normal"
			$VBoxContainer/Description.text = "Move pieces from bottle to bottle to unmix the bottles. Unmix all the bottles to win."
		AutoLoad.mode.ZEN:
			$VBoxContainer/Title.text = "zen"
			$VBoxContainer/Description.text = "Move pieces from bottle to bottle to unmix the bottles. Unmix as many bottles as you want in this infinite game mode."
		AutoLoad.mode.BOTTLEMINO:
			$VBoxContainer/Title.text = "bottlemino"
			$VBoxContainer/Description.text = "Move pieces from bottle to bottle to unmix the bottles. If a mixed bottle fills up it is removed from play. If a bottle is filled with a single color it is emptied and you score a point. The bottles fill every eight moves. Try for a highscore"


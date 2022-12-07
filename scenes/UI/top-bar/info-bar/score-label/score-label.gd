extends Label


func _ready():
	if AutoLoad.game_mode == AutoLoad.mode.BOTTLEMINO:
		self.visible = true

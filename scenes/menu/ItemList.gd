extends ItemList

func _ready():
	select(AutoLoad.game_mode)

func _on_ItemList_item_selected(index):
	AutoLoad.game_mode = index

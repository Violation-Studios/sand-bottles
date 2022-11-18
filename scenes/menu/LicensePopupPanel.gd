extends PopupPanel



func _on_LicensesButton_pressed():
	if not visible:
		popup_centered()
	else:
		visible = not visible

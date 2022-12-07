extends Button

var sound = preload("res://scenes/UI/top-bar/action-bar/sound/sound.png")
var muted = preload("res://scenes/UI/top-bar/action-bar/sound/sound-muted.png")


signal sound_toggled()


func _on_Button_pressed():
	if icon == sound:
		icon = muted
	elif icon == muted:
		icon = sound
	emit_signal("sound_toggled")

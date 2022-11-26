extends Button

var sound = preload("res://assets/sound.png")
var muted = preload("res://assets/sound-muted.png")


func _on_SoundButton_pressed():
	if icon == sound:
		icon = muted
	elif icon == muted:
		icon = sound

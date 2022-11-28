extends Button

var sound = preload("res://assets/sound.png")
var muted = preload("res://assets/sound-muted.png")

signal sound_toggled()


func _on_SoundButton_pressed():
	if icon == sound:
		icon = muted
	elif icon == muted:
		icon = sound
	emit_signal("sound_toggled")

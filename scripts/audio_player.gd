extends Node

const CLICK = preload("res://assets/audio/click.ogg")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "click":
		stream = CLICK
	else:
		print("Invalid sfx name")
		return
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	
	asp.play()
	
	await asp.finished
	asp.queue_free()

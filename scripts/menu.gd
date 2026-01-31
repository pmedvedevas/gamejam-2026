extends Control

@onready var butt1 = $Butt
@onready var butt2 = $Butt2

var t = 0.0

func _process(delta: float) -> void:
	t += delta
	butt1.scale = Vector2(1,1) * (1 + 0.05 * sin(t*6))
	butt2.scale = Vector2(1,1) * (1 + 0.05 * sin(t*6))

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/coolTransition.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

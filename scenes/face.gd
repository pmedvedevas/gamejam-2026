extends Sprite2D

@onready var game := get_tree().current_scene

var character_movement_tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_all()
	

func bobbing():
	character_movement_tween = create_tween()
	character_movement_tween.set_trans(Tween.TRANS_CUBIC)
	character_movement_tween.tween_property(self, "position", Vector2(958.0, 563.029), 1.0)
	character_movement_tween.tween_property(self, "position", Vector2(958.0, 543.029), 1.0)
	character_movement_tween.set_loops()
	#tween.set_ease(Tween.EASE_IN)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func reset_starting_values():
	pass
	
func reset_all():
	kill_all_tweens()
	
	#game.throbbing_countdown.connect(_on_throbing_countdown)
	#game.almost_explode_countdown.connect(_on_almost_explode_countdown)
	
	bobbing()
	
func kill_all_tweens():
	if character_movement_tween:
		character_movement_tween.kill()
		
	reset_starting_values()
	

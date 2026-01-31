extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(958.0, 563.029), 1.0)
	tween.tween_property(self, "position", Vector2(958.0, 543.029), 1.0)
	tween.set_loops()
	#tween.set_ease(Tween.EASE_IN)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

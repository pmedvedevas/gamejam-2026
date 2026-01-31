extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Move this node to (400, 400) over 1 second
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(200, 400), 30.0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

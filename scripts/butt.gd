extends Sprite2D

@onready var but_explosion_visual =  $"../But_BackgroundExplosion"

#In seconds
@onready var game := get_tree().current_scene
@onready var throbing_time = game.TIME_LIMIT - 3
# Called when the node enters the scene tree for the first time.

var UPPER_BUT_POSITION = Vector2(123.0, 793.0)
var LOWER_BUT_POSITION = Vector2(134.0, 851.0)

var but_movement_tween
var explosion_movement_tween

func _ready() -> void:
	# Set timer connection to game
	game.throbbing_countdown.connect(_on_throbing_countdown)
	start_but_movement()

func start_but_movement():
	# Move this node to (400, 400) over 1 second
	but_movement_tween = create_tween()
	but_movement_tween.set_trans(Tween.TRANS_CUBIC)
	but_movement_tween.tween_property(self, "position", UPPER_BUT_POSITION, 1.0)
	but_movement_tween.tween_property(self, "position", LOWER_BUT_POSITION, 1.0)
	but_movement_tween.set_loops()
	#tween.set_ease(Tween.EASE_IN)
	

func but_throbbing() -> void:
	but_explosion_visual.visible = true
	
	explosion_movement_tween = create_tween()
	#tween.tween_property(but_explosion_visual, "visible", !but_explosion_visual.visible, 0.5)
	#tween.tween_property(but_explosion_visual, "visible", !but_explosion_visual.visible, 0.5)
	#tween.set_loops()
	
	explosion_movement_tween.tween_property(but_explosion_visual, "modulate:a", 0.0, 0) # Fade out in 0.5 seconds
	explosion_movement_tween.tween_interval(0.2)                           # Stay invisible for 0.2s
	explosion_movement_tween.tween_property(but_explosion_visual, "modulate:a", 1.0, 0)  # Fade in in 0.5 seconds
	explosion_movement_tween.tween_interval(0.2)                           # Stay visible for 0.2s
	explosion_movement_tween.set_loops()    
	
	
	but_movement_tween = create_tween()
	but_movement_tween.set_trans(Tween.TRANS_CUBIC)
	but_movement_tween.tween_property(self, "position", UPPER_BUT_POSITION + Vector2(10, 0), 0.2)
	but_movement_tween.tween_property(self, "position", LOWER_BUT_POSITION + Vector2(-10, 0), 0.2)
	but_movement_tween.set_loops()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# In another script:

func _on_throbing_countdown():
	but_throbbing()
	
	
func reset_all():
	start_but_movement()
	but_explosion_visual.visible = false

	if explosion_movement_tween:
		explosion_movement_tween.kill()
		
	game.throbbing_countdown.connect(_on_throbing_countdown)
	start_but_movement()
	
func kill_all_tweens():
	but_explosion_visual.visible = false
	if explosion_movement_tween:
		explosion_movement_tween.kill()
		
	but_movement_tween
	if but_movement_tween:
		but_movement_tween.kill()

extends Sprite2D

@onready var but_explosion_visual =  $"../But_BackgroundExplosion"

#In seconds
@onready var game := get_tree().current_scene
@onready var throbing_time = game.TIME_LIMIT - 3
# Called when the node enters the scene tree for the first time.

var UPPER_BUT_POSITION = Vector2(123.0, 820.0)
var LOWER_BUT_POSITION = Vector2(144.0, 851.0)

var but_movement_tween
var but_rotation_tween
var but_size_tween

var explosion_movement_tween
var explosion_color_tween
var explosion_size_tween


func _ready() -> void:
	# Set timer connection to game
	game.throbbing_countdown.connect(_on_throbing_countdown)
	game.almost_explode_countdown.connect(_on_almost_explode_countdown)
	
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
	
	
func but_almost_explode() -> void:
	but_explosion_visual.visible = true
	
	explosion_movement_tween = create_tween()
	explosion_movement_tween.tween_property(but_explosion_visual, "modulate:a", 0.0, 0) # Fade out in 0.5 seconds
	explosion_movement_tween.tween_interval(0.1)                           # Stay invisible for 0.2s
	explosion_movement_tween.tween_property(but_explosion_visual, "modulate:a", 1.0, 0)  # Fade in in 0.5 seconds
	explosion_movement_tween.tween_interval(0.1)                           # Stay visible for 0.2s
	explosion_movement_tween.set_loops()    
	
	explosion_color_tween = create_tween()
	explosion_color_tween.tween_property(but_explosion_visual, "modulate:b", 0.0, 0) # Fade out in 0.5 seconds
	explosion_color_tween.tween_property(but_explosion_visual, "modulate:g", 0.0, 0) # Fade out in 0.5 seconds
	explosion_color_tween.tween_interval(0.3)                           # Stay invisible for 0.2s
	explosion_color_tween.tween_property(but_explosion_visual, "modulate:b", 1.0, 0)  # Fade in in 0.5 seconds
	explosion_color_tween.tween_property(but_explosion_visual, "modulate:g", 1.0, 0)  # Fade in in 0.5 seconds
	explosion_color_tween.tween_interval(0.1)                           # Stay visible for 0.2s
	explosion_color_tween.set_loops()
	
	explosion_size_tween = create_tween()
	explosion_size_tween.set_trans(Tween.TRANS_CUBIC)
	explosion_size_tween.tween_property(but_explosion_visual, "scale", Vector2(1,1), 0.1)
	explosion_size_tween.tween_property(but_explosion_visual, "scale", Vector2(0.4,0.4), 0.1)    
	explosion_size_tween.set_loops()
	
	
	but_movement_tween = create_tween()
	but_movement_tween.set_trans(Tween.TRANS_CUBIC)
	but_movement_tween.tween_property(self, "position", UPPER_BUT_POSITION + Vector2(10, 0), 0.1)
	but_movement_tween.tween_property(self, "position", LOWER_BUT_POSITION + Vector2(-10, 0), 0.1)
	but_movement_tween.set_loops()
	
	but_rotation_tween = create_tween()
	but_rotation_tween.set_trans(Tween.TRANS_CUBIC)
	but_rotation_tween.tween_property(self, "rotation", 0.35, 0.1)
	but_rotation_tween.tween_property(self, "rotation", 0.5, 0.1)
	but_rotation_tween.set_loops()
	
	but_size_tween = create_tween()
	but_size_tween.set_trans(Tween.TRANS_CUBIC)
	but_size_tween.tween_property(self, "scale", Vector2(1.3,1.1), 0.1)
	but_size_tween.tween_property(self, "scale", Vector2(1.05,1), 0.1)
	but_size_tween.set_loops()
	
	
	
	
	
func _on_almost_explode_countdown():
	but_almost_explode()
	
func reset_starting_values():
	but_explosion_visual.visible = false
	
	but_explosion_visual.modulate.b = 1
	but_explosion_visual.modulate.g = 1
	
	self.scale = Vector2(1.2, 1.1)
	self.rotation = 0.349
	self.position = Vector2(134.0,851.0)
	
func reset_all():
	reset_starting_values()

	if explosion_movement_tween:
		explosion_movement_tween.kill()
		
	game.throbbing_countdown.connect(_on_throbing_countdown)
	start_but_movement()
	
func kill_all_tweens():
	reset_starting_values()
	
	if explosion_movement_tween:
		explosion_movement_tween.kill()
		
	if explosion_color_tween:
		explosion_color_tween.kill()
		
	if explosion_size_tween:
		explosion_size_tween.kill()
		
	if but_movement_tween:
		but_movement_tween.kill()
		
	if but_rotation_tween:
		but_rotation_tween.kill()
		
	if but_size_tween:
		but_size_tween.kill()

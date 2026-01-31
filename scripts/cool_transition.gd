extends Control

@onready var player = $Player
@onready var butt = $Butt

var t = 0.0
var P_START = Vector2()
var B_START = Vector2()
var player_target = Vector2(116.0, 37.0)
var butt_target = Vector2(1680.0, -150.0)

var move_duration = 2.0
var hold_time = 2.0
var animation_finished = false

func _ready() -> void:
	P_START = player.position
	B_START = butt.position

func _process(delta: float) -> void:
	
	t += delta
	butt.scale = Vector2(1,1) * (1 + 0.05 * sin(t*6))
	
	if animation_finished:
		return   # stop moving once animation done

	

	# Smoothly move player and butt towards target
	player.position.x = lerp(P_START.x, player_target.x, clamp(t/move_duration, 0.0, 1.0))
	player.position.y = lerp(P_START.y, player_target.y, clamp(t/move_duration, 0.0, 1.0))
	butt.position.x = lerp(B_START.x, butt_target.x, clamp(t/move_duration, 0.0, 1.0))
	butt.position.y = lerp(B_START.y, butt_target.y, clamp(t/move_duration, 0.0, 1.0))

	# Check if animation duration completed
	if t >= move_duration:
		animation_finished = true
		# Start timer for hold before scene change
		var timer = Timer.new()
		timer.wait_time = hold_time
		timer.one_shot = true
		add_child(timer)
		timer.timeout.connect(_on_hold_finished)
		timer.start()

func _on_hold_finished():
	get_tree().change_scene_to_file("res://scenes/game_aurimas.tscn")

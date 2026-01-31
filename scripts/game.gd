extends Node2D

signal throbbing_countdown


signal win
signal lose
signal update_ui(presses: int, required: int, time_left: float)

const TIME_LIMIT := 15.0

var press_count := 0
var time_left := TIME_LIMIT
var level := 1
var required_presses := 5
var presses_increment := 2 # One of the incrementation variable will be unnecessary most likely
var presses_multiplier := 2

enum GameState {
	PLAYING,
	WAITING_NEXT,
	DEAD
}

var state := GameState.PLAYING

@onready var timer_label: Label = $UI/TimerVBoxContainer/HBoxContainer/TimerLabel
@onready var result_label: Label = $UI/ResultVBoxContainer/ResultLabel
@onready var restart_label: Label = $UI/RestartVBoxContainer/RestartLabel
@onready var instruction_label: Label = $UI/InstructionsVBoxContainer/InstructionLabel
@onready var press_label: Label = $UI/PressVBoxContainer/PressLabel

@onready var fart: Sprite2D = $Visuals/Fart
@onready var face: Sprite2D = $Visuals/Face

@onready var face_animation_player: AnimationPlayer = $Visuals/FaceAnimationPlayer
@onready var restart_animation_player: AnimationPlayer = $UI/RestartVBoxContainer/RestartAnimationPlayer
@onready var timing_meter = $TimingMeter

@onready var mask: Sprite2D = $Visuals/Mask
@onready var butt: Sprite2D = $Visuals/Butt




func _ready():
	update_ui_labels()
	reset_all()

func _process(delta):
	if state != GameState.PLAYING:
		return

	time_left -= delta
	if time_left <= 0:
		time_left = 0
		update_ui_labels()

		if press_count < required_presses:
			on_lose()
		return

	update_ui_labels()


func set_throbbing_timer():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.timeout.connect(throbbing_emit)
	timer.start()

func throbbing_emit():
	print("Enabling THROBBING!")
	emit_signal("throbbing_countdown") # custom signal for external use

func _input(event):
	match state:
		GameState.PLAYING:
			if event.is_action_pressed("press_x"):
				if timing_meter.is_good_timing():
					press_count += 1
					update_ui_labels()
					if press_count >= required_presses:
						on_win()
		GameState.WAITING_NEXT:
			if event.is_action_pressed("press_z"):
				next_level()
		GameState.DEAD:
			if event.is_action_pressed("press_enter"):
				restart_game()

func update_ui_labels():
	timer_label.text = str(int(ceil(time_left)))
	if press_label:
		press_label.text = "%d / %d" % [press_count, required_presses]

func restart_game():
	level = 1
	required_presses = 5
	press_count = 0
	time_left = TIME_LIMIT
	state = GameState.PLAYING

	fart.visible = false
	face.visible = true
	result_label.text = ""

	face_animation_player.play("live")
	restart_animation_player.play("disappear")
	mask.calculate_steps()
	mask.set_initial_position()

	update_ui_labels()
	reset_all()
	

func on_win():
	state = GameState.WAITING_NEXT
	result_label.text = "✅ LEVEL %d COMPLETE! ✅" % level
	restart_label.text = "Press Z to go to next fart level"
	fart.visible = true
	restart_animation_player.play("flash")
	emit_signal("win")
	butt.kill_all_tweens()
	

func on_lose():
	state = GameState.DEAD
	result_label.text = "❌ GAME OVER! YOU SUFFOCATED ON LEVEL %d ❌" % level
	restart_label.text = "Press Enter to Restart"
	fart.visible = true
	face_animation_player.play("die")
	mask.visible = false
	restart_animation_player.play("flash")
	emit_signal("lose")
	butt.kill_all_tweens()
	

func start_level():
	press_count = 0
	time_left = TIME_LIMIT
	state = GameState.PLAYING
	fart.visible = false
	face.visible = true
	mask.set_initial_position()
	mask.calculate_steps()
	update_ui_labels()
	

func next_level():
	level += 1
	#required_presses += presses_increment
	required_presses = int(required_presses * presses_multiplier)
	restart_label.text = ""
	result_label.text = ""
	start_level()
	reset_all()
	
func reset_all():
	butt.reset_all()
	set_throbbing_timer()
	

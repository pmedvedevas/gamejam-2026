extends Node2D

signal win
signal lose
signal update_ui(presses: int, required: int, time_left: float)

const REQUIRED_PRESSES := 5
const TIME_LIMIT := 5.0

@onready var game: Node2D = $"."

var press_count := 0
var time_left := TIME_LIMIT
var running := true

@onready var timer_label: Label = $UI/TimerLabel
@onready var press_label: Label = $UI/PressLabel
@onready var instruction_label: Label = $UI/InstructionLabel
@onready var result_label: Label = $UI/ResultLabel

@onready var fart: Sprite2D = $Visuals/Fart
@onready var face: Sprite2D = $Visuals/Face

@onready var face_animation_player: AnimationPlayer = $Visuals/FaceAnimationPlayer
@onready var restart_animation_player: AnimationPlayer = $UI/RestartAnimationPlayer

@onready var mask: Sprite2D = $Visuals/Mask

func _ready():
	update_ui_labels()

func _process(delta):
	if not running:
		return

	time_left -= delta
	if time_left <= 0:
		time_left = 0
		running = false
		update_ui_labels()

		if press_count < REQUIRED_PRESSES:
			on_lose()
		return

	update_ui_labels()

func _input(event):
	if not running:
		if event.is_action_pressed("press_enter"):
			restart_game()
		return

	if event.is_action_pressed("press_x"):
		#AudioPlayer.play_sfx("click")
		press_count += 1
		update_ui_labels()

		if press_count >= REQUIRED_PRESSES:
			running = false
			on_win()

func update_ui_labels():
	timer_label.text = str(int(ceil(time_left)))
	if press_label:
		press_label.text = "%d / %d" % [press_count, REQUIRED_PRESSES]

func restart_game():
	press_count = 0
	time_left = TIME_LIMIT
	running = true

	fart.visible = false
	face.visible = true
	result_label.text = ""
	
	face_animation_player.play("live")
	restart_animation_player.play("disappear")
	
	mask.set_initial_position()
	
	update_ui_labels()

func on_win():
	result_label.text = "✅ YOU WIN! ✅"
	fart.visible = true
	#face.visible = false
	restart_animation_player.play("flash")
	emit_signal("win")

func on_lose():
	result_label.text = "❌ LOSER! ❌"
	fart.visible = true
	face_animation_player.play("die")
	mask.visible = false
	restart_animation_player.play("flash")
	emit_signal("lose")

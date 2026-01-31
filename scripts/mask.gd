extends Node2D

@onready var game := get_tree().current_scene
@onready var face: Sprite2D = $"../Face"

const START_Y := 920.0

var end_y
var steps
var total_distance
var step_size

func _ready():
	#end_y = face.transform.get_origin()[1]
	end_y = 360 # Temporary hardcoded value :)
	position.y = START_Y
	calculate_steps()
	
func calculate_steps():
	var required_presses = game.required_presses
	total_distance = START_Y - end_y
	steps = required_presses
	step_size = total_distance / float(steps)

func _input(event):
	if event.is_action_pressed("press_x"):
		lift_mask()

func lift_mask():
	position.y -= step_size

	if position.y < end_y:
		position.y = end_y

func set_initial_position():
	position.y = START_Y
	visible = true

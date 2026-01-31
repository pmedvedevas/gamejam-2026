extends Control

@onready var bar: TextureProgressBar = $Bar
@onready var arrow: TextureRect = $Arrow

var speed := 150.0
var direction := 1

func _ready():
	arrow.position.x = 0
	arrow.position.y = bar.position.y - arrow.size.y
	print(bar.size.x)

#func _input(event):
	#if event.is_action_pressed("press_x"):
		#var val = get_arrow_value()
		#var zone = get_good_zone()
		#if is_good_timing():
			#print("✅ GOOD TIMING | Valuex:", val, " Zone:", zone)
		#else:
			#print("❌ BAD TIMING  | Value:", val, " Zone:", zone)

func _process(delta):
	arrow.position.x += speed * direction * delta

	var arrow_half := arrow.size.x / 2
	var left_limit := -arrow_half
	var right_limit := bar.size.x - arrow_half

	if arrow.position.x >= right_limit:
		arrow.position.x = right_limit
		direction = -1
	elif arrow.position.x <= left_limit:
		arrow.position.x = left_limit
		direction = 1

func get_arrow_value() -> float:
	var arrow_center_x = arrow.position.x + arrow.size.x / 2
	var usable_width = bar.size.x - bar.texture_progress_offset.x * 2
	var normalized = (arrow_center_x - bar.texture_progress_offset.x) / usable_width
	normalized = clamp(normalized, 0.0, 1.0)
	return lerp(bar.min_value, bar.max_value, normalized)

func get_good_zone() -> Vector2:
	var min_val = bar.min_value
	var max_val = bar.max_value
	var start_val = lerp(min_val, max_val, 0.4)
	var end_val   = lerp(min_val, max_val, 0.6)
	return Vector2(start_val, end_val)

func is_good_timing() -> bool:
	var value = get_arrow_value()
	var zone = get_good_zone()
	return value >= zone.x and value <= zone.y

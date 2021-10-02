class_name ProgressMeter
extends Sprite

signal meter_empty
signal meter_full

var progress setget set_progress, get_progress
var steps setget set_steps, get_steps
var count_down setget set_count_down, get_count_down

func _ready():
	self.translate(Vector2(-18,-8))


func _draw():
	var width = 24/steps
	draw_rect(
		Rect2(
			Vector2(-1, -1),
			Vector2(26, 10)
		),
		Color("FFFFFF")
	)
	
	for segment in range(progress):
		draw_rect(
			Rect2(
				Vector2(width*segment, 0),
				Vector2(width -1, 8)
			),
			Color("FF0000")
		)
		
func decrease_step():
	progress -= 1
	update()
	if count_down and progress == 0:
		emit_signal("meter_empty")
		
func increase_step():
	progress =+ 1
	update()
	if not count_down and progress == steps:
		emit_signal("meter_full")
	
func set_progress(value):
	progress = value
	
func get_progress():
	return progress
	
func set_steps(value):
	steps = value
	
func get_steps():
	return steps

func get_count_down():
	return count_down
	
func set_count_down(value):
	count_down = value

class_name ProgressMeter
extends Node

signal meter_empty
signal meter_full

var progress setget set_progress, get_progress
var steps setget set_steps, get_steps

# Called when the node enters the scene tree for the first time.
func _ready():
	var metronome = get_node(@"/root/Root").metronome
	metronome.connect("full_beat")
	
func _draw():
	width = 32/steps
	for segment in range(progress):
		draw_rect(
			Rect2(
				Vector2(32*segment, 0),
				Vector2(width -1, 8)
			),
			Color("red")
		)
		draw_rect(
			Rect2(
				Vector2((32*segment+1)-1, 0),
				Vector2(1, 8)
			),
			Color("black")
		)
		
func decrease_counter():
	progress -= 1
	update()

class_name Metronome
extends Node2D

const BPM_136 = 0.055
const BPM_121 = 0.062

signal beat_32nd
signal beat_16th
signal beat_8th
signal beat_4th
signal beat_half
signal beat_full

var timer

var count_beat = 32
var count_half = 16
var count_4th = 8
var count_8th = 4
var count_16th = 2
var count_32nd = 1

func _init():
	timer = Timer.new()
	self.add_child(timer)
	timer.set_autostart(true)
	timer.set_timer_process_mode(0)
	timer.set_wait_time(BPM_121)  # 136bpm = 55ms for a semidemiquaver
	timer.connect("timeout", self, "_on_32nd")
	timer.set_one_shot(false)
	
		
func _on_32nd():
	count_32nd -= 1
	if count_32nd == 0:
		emit_signal("beat_32nd")
		count_32nd = 1
		
	count_16th -= 1
	if count_16th == 0:
		emit_signal("beat_16th")
		count_16th = 2
		
	count_8th -= 1
	if count_8th == 0:
		emit_signal("beat_8th")
		count_8th = 4
		
	count_4th -= 1
	if count_4th == 0:
		emit_signal("beat_4th")
		count_4th = 8
		
	count_half -= 1
	if count_half == 0:
		emit_signal("beat_half")
		count_half = 16
		
	count_beat -= 1
	if count_beat == 0:
		emit_signal("beat_full")
		count_beat = 32


func start():
	timer.start()
	
func pause():
	timer.pause()

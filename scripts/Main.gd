extends Node2D


var input_valid = false
var chop_player

var metronome
# Called when the node enters the scene tree for the first time.
func _enter_tree():
	
	chop_player = AudioStreamPlayer.new()
	chop_player.set_stream(load("res://assets/samples/chop.wav"))
	chop_player.set_volume_db(0)
	self.add_child(chop_player)
	
	metronome = Metronome.new()
	self.add_child(metronome, true)
	metronome.connect("beat_16th", self, "off_beat")
	metronome.connect("beat_4th", self, "on_beat")
	metronome.connect("beat_4th", self, "play_kick")
	metronome.start()

func on_beat():
	if not input_valid:
		input_valid = true
	
func off_beat():
	if input_valid:
		input_valid = false
	
func _input(event):
	if event is InputEventKey:
		if event is InputEventKey and event.pressed:
			if event.scancode == KEY_SPACE:
				if input_valid:
					print_debug("Nice!")
				else:
					print_debug("Miss!")

func _chop():
	pass

func play_kick():
	chop_player.play()

######## AFK########

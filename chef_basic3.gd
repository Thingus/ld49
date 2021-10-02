extends Sprite

var down = false

func _ready():
	var root = get_node(@"/root/Root")
	root.metronome.connect("beat_8th", self, "_bob_down")
	#root.metronome.connect("beat_16th", self, "_bob_up")

func _bob_down():
	if not down:
		self.translate(Vector2(0,-5))
		down = true
	else:
		self.translate(Vector2(0,5))
		down = false

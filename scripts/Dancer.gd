extends Sprite

var down = false

func _ready():
	var root = get_node(@"/root/Root")
	root.metronome.connect("beat_4th", self, "_bob_down")
	root.metronome.connect("beat_16th", self, "_bob_up")

func _bob_down():
	self.translate(Vector2(0,5))
	down = true
	
func _bob_up():
	if down:
		self.translate(Vector2(0,-5))
		down = false

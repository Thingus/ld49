extends Sprite

var stepping = false

func _ready():
	var root = get_node(@"/root/Root")
	root.metronome.connect("beat_4th", self, "_step")

func _step():
	if not stepping:
		self.translate(Vector2(5,0))
		stepping = true
	else:
		self.translate(Vector2(-5,0))
		stepping = false
	

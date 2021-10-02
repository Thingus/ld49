extends Sprite

var stepping = false
var patience

func _ready():
	var metronome = get_node(@"/root/Root").metronome
	metronome.connect("beat_4th", self, "_step")
	patience = ProgressMeter.new()
	add_child(patience)
	patience.translate(Vector2(0,-18))
	patience.set_steps(4)
	patience.set_progress(4)
	metronome.connect("beat_full", patience, "decrease_step")
	
func _step():
	if not stepping:
		self.translate(Vector2(5,0))
		stepping = true
	else:
		self.translate(Vector2(-5,0))
		stepping = false
	

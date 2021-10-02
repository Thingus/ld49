extends "res://scripts/Dancer.gd"

var large = false

func _bob_down():
	self.set_scale(Vector2(1.2,1.2))
	large = true
	
func _bob_up():
	if large:
		self.set_scale(Vector2(1,1))
		large = false

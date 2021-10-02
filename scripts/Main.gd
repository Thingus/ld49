extends Node2D


var input_valid = false
var chop_player

var left_ingredient_queue = []
var right_ingredient_queue = []
var left_menu_queue = []
var right_menu_queue = []

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


class Rhythmic extends Sprite:
	var input_valid = false
	var metronome
	
	func _init():
		metronome = get_node(@"/root/Root").metronome
		metronome.connect("beat_16th", self, "off_beat")
		metronome.connect("beat_4th", self, "on_beat")
		
	func on_beat():
		if not input_valid:
			input_valid = true
	
	func off_beat():
		if input_valid:
			input_valid = false


class SpriteQueue extends Node2D:
	
	var items = []
	var size
	exposed var margin = 2
	
	func _init(size):
		size = size
		
	func item = 
		
	func _draw():
		for item in items:
			item.draw()
			
	func add(item : Sprite):
		items.append(item)
		item.transform()
		item.connect(served)

#State management classes
class Customer:
	func _init(order: MenuItem, menu_queue : SpriteQueue):
		self.order = order(menu_queue)


class PrepStation:
	var key


class MenuItem extends Sprite:
	
	signal order(ingredients)
	signal complete
	var ingredients
	var prepped_ingredients =0
	var is_complete = false
	var outline_sprite
	var prepped_sprite

	func _init(menu_queue):
		emit_signal("order", self.ingredients)
		for ingredient in ingredients:
			ingredient.connect("prepared", self, "inc_comp_ingredient")
		set_texture(prepped_sprite)
		menu_queue.add(self)
			
	func inc_comp_ingredient():
		prepped_ingredients += 1
		if prepped_ingredients == len(ingredients):
			is_complete = true
			for ingredient in ingredients:
				ingredient.queue_free()
			set_texture(prepped_sprite)


class Salad extends MenuItem:

	func _init(menu_queue):
		prepped_salad_sprite = load("res://assets/sprites/prepped_salad_outline.png")
		outline_sprite = load("res://assets/sprites/prepped_salad_outline.png")
		ingredients = [Letticue.new()]
		._init(menu_queue)


class Ingredient extends Rhythmic:
	signal prepared
	var station
	var prep 
	var current_prep = 0
	var prog_bar
	var raw_texture
	var prepped_texture
	
	func _init(station : PrepStation):
		prog_bar = ProgressMeter.new()
		prog_bar.set_count_down(false)
		prog_bar.set_steps(3)
		prog_bar.set_progress(0)
		prog_bar.connect("meter_full", self, "complete")
		station = station
		set_texture(raw_texture)
		
	func complete():
		emit_signal("prepared")
		set_texture(prepped_texture)


class Letticue extends Ingredient:
	
	func _init():
		var raw_texture = load("res://assets/sprites/letticue.png")
		var prepped_texture = load("res://assets/sprites/shredded_lettuc.png")
	
	func chop_once():
		prog_bar.increase_step()
	
	func _input(event):
		if event is InputEventKey and event.pressed:
			if event.scancode == self.station.scancode and input_valid:
				chop_once()
				

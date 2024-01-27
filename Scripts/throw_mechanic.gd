extends HSlider

var is_max := false
var is_stop := false
var is_on_point := false

export(float) var percentage: float = 80.0 
var bot_bar: float
var top_bar: float

onready var player = get_parent().get_parent()

func _ready():
	self.connect("value_changed", self, "track_value")
	calc_green_hint(percentage)
	calc_throw_point(percentage)

func calc_green_hint(percent: float):
	var size_factor = percent / 100.0
	var x_len = $GreenBackground.rect_size.x * size_factor
	$GreenBackground.margin_left = x_len/2.0
	$GreenBackground.margin_right = -x_len/2.0

func _process(delta):
	if not is_stop:
		if not is_max:
			self.value += self.step
		else:
			self.value -= self.step

func track_value(value: float):
	if value == self.max_value:
		is_max = true
	elif value == self.min_value:
		is_max = false
	
	if value >= bot_bar and value <= top_bar:
		is_on_point = true
	else:
		is_on_point = false
#	print(is_on_point)

func calc_throw_point(percent: float):
	var val_percentage = self.max_value * (percent / 100.0)
	bot_bar = self.min_value + val_percentage/2.0
	top_bar = self.max_value - val_percentage/2.0
#	print("percentage : ", val_percentage)
#	print("bot_bar : ", bot_bar)
#	print("top_bar : ", top_bar)
	

func _input(event):
	if event.is_action_pressed("throw"):
		is_stop = true
		if is_on_point:
			player.throw()

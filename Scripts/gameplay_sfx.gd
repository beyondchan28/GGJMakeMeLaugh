extends AudioStreamPlayer

func _ready():
	self.connect("finished", self, "sfx_end")

func sfx_end():
	if self.is_playing():
		print("Happen")
		self.stop()

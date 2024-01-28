extends Button

func _ready():
	self.connect("pressed", self, "pausing")

func pausing():
	get_tree().paused = true
	get_parent().get_node("InGameMenu").popup()
#	print("pause")

func unpausing():
	get_parent().get_node("InGameMenu").hide()
#	print("unpause")

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("pause"):
		if !get_tree().is_paused():
			pausing()
		else:
			unpausing()

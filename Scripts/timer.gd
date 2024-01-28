extends Label

var curr_sec = 0
var curr_min = 0

export var default_sec = 30
export var default_min = 1

func _ready():
	$Timer.connect("timeout", self, "timeout")
	reset_timer()

func timeout():
	if curr_sec == 0:
		if curr_min > 0:
			curr_min -= 1
			curr_sec = 60
	curr_sec -= 1
	
	if curr_min == 0 and curr_sec == 0:
		$Timer.stop()
#		get_tree().paused = true
#		get_parent().get_node("GameOverUI").popup()
		print("YOU LOSE !")
	
	self.text = String(curr_min) + ":" + String(curr_sec)

func reset_timer():
	curr_sec = default_sec
	curr_min = default_min

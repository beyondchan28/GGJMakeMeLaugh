extends Popup

func _ready():
	self.connect("popup_hide", self, "unpaused")
	$Background/ButtonContainer/ResumeButton.connect("pressed", self, "resume")
	$Background/ButtonContainer/MainMenuButton.connect("pressed", self, "back_to_main_menu")

func back_to_main_menu():
	get_tree().paused = false
	SceneManager.change_scene("res://Scenes/MainMenu.tscn", {"pattern" : "curtains"})

func resume():
#	get_tree().paused = false
	self.hide()

func unpaused():
	get_tree().paused = false
	

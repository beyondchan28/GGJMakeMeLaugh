extends Popup

func _ready():
	$Background/ButtonContainer/RestartButton.connect("pressed", self, "restart")
	$Background/ButtonContainer/MainMenuButton.connect("pressed", self, "back_to_main_menu")

func restart():
	SceneManager.reload_scene({"pattern" : "radial"})
	get_tree().paused = false

func back_to_main_menu():
	get_tree().paused = false
	SceneManager.change_scene("res://Scenes/MainMenu.tscn", {"pattern" : "curtains"})

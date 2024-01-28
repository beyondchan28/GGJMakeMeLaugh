extends Control

func _ready():
	$ButtonContainer/PlayButton.connect("pressed", self, "play")
	$ButtonContainer/HowToPlayButton.connect("pressed", self, "how_to")
	$ButtonContainer/CreditButton.connect("pressed", self, "credit")
	$ButtonContainer/ExitButton.connect("pressed", self, "exit")
	
	$CreditPopup/CloseButton.connect("pressed", self, "hide_credit")
	$HowToPlayPopup/CloseButton.connect("pressed", self, "hide_how_to")

func play():
	SceneManager.change_scene("res://Scenes/World.tscn", {"pattern" : "scribbles"})

func how_to():
	$HowToPlayPopup.popup()

func hide_how_to():
	$HowToPlayPopup.hide()

func credit():
	$CreditPopup.popup()

func hide_credit():
	$CreditPopup.hide()

func exit():
	self.get_tree().quit()

extends Area2D

#condition dialogure when throw on target, when miss, 

export(Resource) var _dialogue = _dialogue as Dialogue

func _ready():
	self.connect("body_entered", self, "player_entered")

func player_entered(body):
	if body.name == "Player":
		GameEvents.emit_signal("dialog_initiated", _dialogue)

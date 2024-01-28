extends Area2D

onready var anger_meter = $Control/AngerMeter
onready var anim = $AnimatedSprite

func _ready():
	anger_meter.connect("value_changed", self, "anger_meter_changed")

func pissed_off(anger_damage):
	anger_meter.value += anger_damage
	anim.play("fall")
	yield(anim, "animation_finished")
	anim.play("after_hit")
	yield(anim, "animation_finished")
	anim.play("idle")
	

func anger_meter_changed(val: float):
	print(val)
	if val < 50.0:
		print("First Ending")
	else:
		print("Other Ending")
		

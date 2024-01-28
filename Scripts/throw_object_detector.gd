extends Area2D

onready var player = get_parent()
export(Resource) var dialogue_when_had_object = dialogue_when_had_object as Dialogue

func _ready():
	self.connect("area_entered", self, "object_detected")
	self.connect("area_exited", self, "object_undetected")

func _physics_process(delta):
	var coll_areas = self.get_overlapping_areas()
	for area in coll_areas:
		if area.is_in_group("pickup_obj"):
			if !player.is_has_throw_obj and Input.is_action_just_pressed("interact"):
#				print("happen")
				player.set_throw_obj(area.texture, area.anger_damage, area.dialogue_if_hit_enemy, area.vfx_name, area.sfx_if_hit_enemy)
				player.get_node("Throw/HSlider").set_calc_diff(area.diff_percentage)
				GameEvents.emit_signal("dialog_initiated", area.pickup_dialogue)
				area.get_node("SFXPickup").playing = true
				yield(area.get_node("SFXPickup"), "finished")
				area.queue_free()
				self.set_physics_process(false)
			elif player.is_has_throw_obj and Input.is_action_just_pressed("interact"):
				GameEvents.emit_signal("dialog_initiated", dialogue_when_had_object)

func object_detected(area):
	area.get_node("HolyEffect").set_visible(true)
	self.set_physics_process(true)

func object_undetected(area):
	area.get_node("HolyEffect").set_visible(false)
	self.set_physics_process(false)

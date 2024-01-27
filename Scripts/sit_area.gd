extends Area2D

func _physics_process(delta):
	var coll_bodies = self.get_overlapping_bodies()
	for body in coll_bodies:
		if body.name == "Player" and body.is_has_throw_obj:
			if Input.is_action_just_pressed("interact"):
				print("SITDOWN")
				body.set_physics_process(false)
				body.get_node("AnimatedSprite").set_flip_h(false)
				body.play_anim("sit_down")
				yield(body.anim, "animation_finished")
				set_slider_enabled(body)
				self.set_physics_process(false)

func set_slider_enabled(body):
	body.get_node("Throw/HSlider").set_visible(true)
	body.get_node("Throw/HSlider").set_process(true)
	body.get_node("Throw/HSlider").set_process_input(true)

extends KinematicBody2D


const UP = Vector2.UP
const DOWN = Vector2.DOWN
const MAX_SPEED = 200
const GRAVITY = 15
const ACCELERATION = 50
const JUMP_HEIGHT = -400

var motion = Vector2.ZERO

enum STATES {MOVE, JUMP, SIT}
var curr_state = STATES.MOVE
var is_has_throw_obj := false

onready var thrown_obj = preload("res://Scenes/ThrownObject.tscn")
onready var enemy = self.get_parent().get_node("Classroom/Enemy")
onready var anim = $AnimatedSprite

var obj_to_throw

export(Resource) var runtime_data = runtime_data as RuntimeData

func _physics_process(delta):
	if runtime_data.current_gameplay_state == GameEvents.GameplayState.FREEWALK:
		motion.y += GRAVITY
		var fraction = false
		if Input.is_action_pressed("right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			anim.set_flip_h(false)
			play_anim("walk")
		elif Input.is_action_pressed("left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			anim.set_flip_h(true)
			play_anim("walk")
		else:
			play_anim("idle")
			fraction = true
		
		if self.is_on_floor():
			curr_state = STATES.MOVE
			if Input.is_action_just_pressed("jump"):
				curr_state = STATES.JUMP
				play_anim("jump")
				motion.y = JUMP_HEIGHT 
			if fraction == true :
				motion.x = lerp(motion.x, 0, 0.2)
		elif not self.is_on_floor():
			play_anim("fall")
			if fraction == true :
				motion.x = lerp(motion.x, 0, 0.05)
		
		motion = self.move_and_slide_with_snap(motion,DOWN, UP, true)

func play_anim(anim_name):
	if anim.get_animation() == anim_name:
		return
	elif curr_state == STATES.JUMP:
		anim.play("jump")
		return
	anim.play(anim_name)

func set_throw_obj(texture: Texture, anger_damage: int, dialogue_if_hit_enemy: Resource, vfx_name: String):
	is_has_throw_obj = true
	obj_to_throw = thrown_obj.instance()
	obj_to_throw.damage = anger_damage
	obj_to_throw.vfx_name = vfx_name
	obj_to_throw.dialogue_when_hit = dialogue_if_hit_enemy
	obj_to_throw.get_node("Sprite").set_texture(texture)

func throw(target_pos):
	play_anim("throw")
	yield(anim, "animation_finished")
	self.get_parent().add_child(obj_to_throw)
	obj_to_throw.position = $ThrowPos.global_position
	obj_to_throw.launch(target_pos)
	is_has_throw_obj = false
	self.set_physics_process(true)
	self.get_parent().get_node("Classroom/SitArea").set_physics_process(true)

func on_point_throw():
	if obj_to_throw != null:
		if enemy:
			throw(enemy.position)
	else:
		print("object_to_throw is null")

func miss_throw():
	if obj_to_throw != null:
		var miss_poses = enemy.get_node("MissPos").get_children()
		var rand_pos = miss_poses[randi() % miss_poses.size()].global_position
		throw(rand_pos)
	else:
		print("object_to_throw is null")

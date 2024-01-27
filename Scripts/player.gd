extends KinematicBody2D


const UP = Vector2.UP
const DOWN = Vector2.DOWN
const MAX_SPEED = 200
const GRAVITY = 15
const ACCELERATION = 50
const JUMP_HEIGHT = -400

var motion = Vector2.ZERO

enum STATES {MOVE, JUMP}
var curr_state = STATES.MOVE

onready var thrown_obj = preload("res://Scenes/ThrownObject.tscn")
onready var enemy = self.get_parent().get_node("Classroom/Enemy")
onready var anim = $AnimatedSprite

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

func throw():
	var obj = thrown_obj.instance()
	self.get_parent().add_child(obj)
	obj.position = self.position
	if enemy:
		obj.launch(enemy.position)


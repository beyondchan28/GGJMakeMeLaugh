extends KinematicBody2D

const GRAVITY  = 1000

var vel = Vector2.ZERO
var original_rotation = 0.0

onready var screen_size = get_viewport_rect().size


func _ready():
	pass
	

func _physics_process(delta):
	vel.y += GRAVITY * delta
	
	move_and_collide(vel * delta)

func calc_arc_vel(source_pos, target_pos, arc_height, gravity):
	var vel = Vector2.ZERO
	var displacement = target_pos - source_pos
	
	if displacement.y > arc_height:
		var time_up = sqrt(-2 * arc_height / float(GRAVITY))
		var time_down = sqrt(2 * (displacement.y - arc_height) / float(GRAVITY))
		
		vel.y = -sqrt(-2 * GRAVITY * arc_height)
		vel.x = displacement.x / float(time_up + time_down)
	
	return vel

func launch(target_position):
	var direction = (target_position - position).normalized()
#	if direction.x < 0: # left
#		$Sprite.rotation_degrees = -135
#	original_rotation = $Sprite.rotation
	# calculate arc_height based on distance
	var distance = abs(target_position.x - global_position.x)
	var max_height = (distance / screen_size.x) * screen_size.y * 0.4
	
	var arc_height = target_position.y - global_position.y - max_height
	arc_height = min(arc_height, -max_height)
#	print("height %s" % arc_height)
	
	vel = calc_arc_vel(global_position, target_position, arc_height, GRAVITY)

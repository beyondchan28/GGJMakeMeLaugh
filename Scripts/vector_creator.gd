extends Area2D

signal vector_created(vector)

export var max_length := 200

var touch_down := false
var pos_start := Vector2.ZERO
var pos_end := Vector2.ZERO

var vec := Vector2.ZERO

#if wanna throw, player cant move

func _ready():
	self.connect("input_event", self, "on_input_event")

func _draw():
	draw_line(pos_start - self.global_position, (pos_end - self.global_position), Color.blue, 8)
	draw_line(pos_start - self.global_position, (pos_start - self.global_position + vec), Color.red, 16)

func reset():
	pos_start = Vector2.ZERO
	pos_end = Vector2.ZERO
	vec = Vector2.ZERO
	update()

func _input(event):
	if not touch_down:
		return
	
	if event.is_action_released("throw"):
		touch_down = false
		emit_signal("vector_created", vec)
		reset()
	
	if event is InputEventMouseMotion:
		pos_end = event.position
		vec = -(pos_end - pos_start).clamped(max_length)
		update()

func on_input_event(_viewport, event, _shaped_idx):
	if event.is_action_pressed("throw"):
		touch_down = true
		pos_start = event.position

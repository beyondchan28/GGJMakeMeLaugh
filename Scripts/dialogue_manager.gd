extends ColorRect

export(NodePath) onready var _dialog_text = get_node(_dialog_text) as Label
export(NodePath) onready var _avatar = get_node(_avatar) as TextureRect
export(NodePath) onready var _next_dialogue_button = get_node(_next_dialogue_button) as Button
var _current_dialogue: Dialogue

export(Resource) var _runtime_data = _runtime_data as RuntimeData

var _current_slides_index := 0

func _ready():
	self.set_visible(false)
	
	_next_dialogue_button.connect("pressed", self, "_next_slide")
	
	GameEvents.connect("dialog_initiated", self, "_on_dialog_initiated")
	GameEvents.connect("dialog_finished", self, "_on_dialog_finished")

func _next_slide():
	if _current_dialogue != null:
		if _current_slides_index < _current_dialogue.dialog_slides.size() - 1:
			_current_slides_index += 1
			show_slide()
		else:
			GameEvents.emit_signal("dialog_finished")

func _unhandled_key_input(event):
	if event.is_action_pressed("next_dialogue"):
		_next_slide()

func show_slide():
	_dialog_text.text = _current_dialogue.dialog_slides[_current_slides_index]

func _on_dialog_initiated(dialogue: Dialogue):
	_set_visibility_other_ui(false)
	_runtime_data.current_gameplay_state = GameEvents.GameplayState.IN_DIALOG
	_current_dialogue = dialogue
	_current_slides_index = 0
	_avatar.texture = dialogue.avatar_texture
	show_slide()
	self.visible = true
	
func _on_dialog_finished():
	_set_visibility_other_ui(true)
	_runtime_data.current_gameplay_state = GameEvents.GameplayState.FREEWALK
	self.visible = false

func _set_visibility_other_ui(hide: bool):
	self.set_visible(hide)
#	var array_node_ui = self.get_children()
#	for i in get_parent().get_child_count() - 1:
#		array_node_ui[i].set_visible(hide)

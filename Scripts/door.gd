extends Area2D

export(String) var from_level_part_name: String = "Classroom"
export(String) var to_level_part_name: String = "Corridor"
var to_level_part_node: Node2D

onready var player = get_tree().get_root().get_node("World/Player")

func _ready():
	to_level_part_node = get_tree().get_root().get_node("World/" + to_level_part_name)

func _physics_process(delta):
	var coll_bodies = self.get_overlapping_bodies()
	for body in coll_bodies:
		if body.name == "Player":
			if Input.is_action_just_pressed("interact"):
#				print("INTERACT WITH DOOR")
				detect_doors()

func detect_doors():
	var doors = to_level_part_node.get_node("Doors").get_children()
	for door in doors:
		if from_level_part_name == door.to_level_part_name:
			player.global_position = door.get_node("DoorPos").global_position
			player.get_node("Camera2D").global_position = door.get_node("DoorPos").global_position
			return
	print("Level part name not found")

extends Area2D

export(float) var diff_percentage:float = 75.0 
export(Texture) var texture: Texture
var anger_damage: int = 5

func _ready():
	$Sprite.set_texture(texture)

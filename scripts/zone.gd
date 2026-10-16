extends Node2D

var zone_name: String = ""

@onready var sprite: Sprite2D = $Sprite2D

func setup(new_name: String, picture: Texture2D) -> void:
	zone_name = new_name
	sprite.texture = picture

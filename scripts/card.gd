extends Node2D

signal tapped(card: Node2D)

const CARD_IMAGE_DIR := "res://images/DotH_Cards_Heartland/fronts/"
const LIFT_AMOUNT = -40.0

var card_id: String = ""
var data: Dictionary = {}
var selected: bool = false

@onready var sprite: Sprite2D = $Sprite2D

func setup(card_data: Dictionary) -> void:
	data = card_data
	card_id = card_data["id"]
	sprite.texture = load(CARD_IMAGE_DIR + card_id + ".png")

func toggle_selected() -> void:
	selected = not selected
	sprite.position.y = LIFT_AMOUNT if selected else 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if sprite.get_rect().has_point(sprite.get_local_mouse_position()):
			tapped.emit(self)

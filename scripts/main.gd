extends Node2D

const CARD_SCENE := preload("res://scenes/card.tscn")
const HAND_START := Vector2(170, 220)
const CARD_SPACING := 280.0
const ZONE_SCENE := preload("res://scenes/zone.tscn")
const PATH_TILE_TEX := preload("res://images/zones/Card_Zone_Path_Tile.png")
const PATH_NAMES = ["P1","P2","P3","P4","P5"]
const PATH_START_X = 300
const PATH_SPACING = 420

var cards: Dictionary = {}

func _ready() -> void:
	cards = load_cards("res://data/DefenseoftheHearthCards.json")
	print("Loaded ", cards.size(), " cards")
	show_hand(["HTL-001", "HTL-002", "HTL-004", "HTL-005"])
	for i in PATH_NAMES.size():
		var x = PATH_START_X + ( i * PATH_SPACING)
		make_zone(PATH_NAMES[i], PATH_TILE_TEX, Vector2(x, 500))

func load_cards(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	var text := file.get_as_text()
	return JSON.parse_string(text)

func show_hand(ids: Array) -> void:
	for i in ids.size():
		var card := CARD_SCENE.instantiate()
		add_child(card)
		card.setup(cards[ids[i]])
		card.position = HAND_START + Vector2(CARD_SPACING * i, 0)
		card.tapped.connect(_on_card_tapped)

func _on_card_tapped(card: Node2D) -> void:
	print("Tapped"," ", card.data["name"])
	card.toggle_selected()

func make_zone(zone_name: String, picture: Texture2D, pos: Vector2) -> void:
	var zone := ZONE_SCENE.instantiate()
	add_child(zone)
	zone.setup(zone_name, picture)
	zone.position = pos

extends Node2D

const CARD_SCENE := preload("res://scenes/card.tscn")
const HAND_START := Vector2(170, 220)
const CARD_SPACING := 280.0
const ZONE_SCENE := preload("res://scenes/zone.tscn")
const PATH_TILE_TEX := preload("res://images/zones/Card_Zone_Path_Tile.png")
const PATH_NAMES = ["P5","P4","P3","P2","P1"]
const PATH_START_X = 300
const PATH_SPACING = 420
const TEST_ZONE := "P1"
const DESIGN_WIDTH := 2304.0
const DESIGN_HEIGHT := 1356.0

var cards: Dictionary = {}
var zones: Dictionary = {}

@onready var game_board: Node2D = $GameBoard
@onready var p1_board: Node2D = $GameBoard/Player1Board
@onready var p2_board: Node2D = $GameBoard/Player2Board


func _ready() -> void:
	cards = load_cards("res://data/DefenseoftheHearthCards.json")
	print("Loaded ", cards.size(), " cards")
	#show_hand(["HTL-001", "HTL-002", "HTL-004", "HTL-005"])
	for i in PATH_NAMES.size():
		var x = PATH_START_X + ( i * PATH_SPACING)
		make_zone(PATH_NAMES[i], PATH_TILE_TEX, Vector2(x, 500))
	print("P1 Position ",zones["P1"].position)
	print("Viewport Size ",get_viewport_rect().size)
	get_viewport().size_changed.connect(_on_viewport_resized)
	_on_viewport_resized()

func _on_viewport_resized() -> void:
	var size := get_viewport_rect().size
	var sx := size.x / DESIGN_WIDTH
	var sy := size.y / DESIGN_HEIGHT
	var s := minf(sx, sy)
	game_board.scale = Vector2(s, s)
	game_board.position = size * .5
	

func load_cards(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	var text := file.get_as_text()
	return JSON.parse_string(text)

func show_hand(ids: Array) -> void:
	for i in ids.size():
		var card := CARD_SCENE.instantiate()
		game_board.add_child(card)
		card.setup(cards[ids[i]])
		card.position = HAND_START + Vector2(CARD_SPACING * i, 0)
		card.tapped.connect(_on_card_tapped)

func _on_card_tapped(card: Node2D) -> void:
	print("Tapped"," ", card.data["name"])
	card.position = zones[TEST_ZONE].position
	card.toggle_selected()


func make_zone(zone_name: String, picture: Texture2D, pos: Vector2) -> void:
	var zone := ZONE_SCENE.instantiate()
	p1_board.add_child(zone)
	zones[zone_name] = zone
	zone.setup(zone_name, picture)
	zone.position = pos

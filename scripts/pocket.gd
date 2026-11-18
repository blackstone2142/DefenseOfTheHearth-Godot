extends RefCounted

class_name Pocket

const UNCAPPED := -1

var cards: Array = []
var cap: int
var allowed_types: Array = []
var blocked_types: Array = []
var allowed_supertypes: Array = []

func setup(new_cap: int, new_types: Array = [], new_blocked: Array = [], new_supertypes: Array = []) -> void:
	cap = new_cap
	allowed_types = new_types
	blocked_types = new_blocked
	allowed_supertypes = new_supertypes

func is_full() -> bool:
	if cap == UNCAPPED:
		return false
	return cards.size() >= cap

func accepts_card(card: Dictionary) -> bool:
	if card["type"] in blocked_types:
		return false
	if not allowed_types.is_empty() and not card["type"] in allowed_types:
		return false
	if not allowed_supertypes.is_empty() and not card["superType"] in allowed_supertypes:
		return false
	return true

func can_add(card: Dictionary) -> bool:
	return not is_full() and accepts_card(card)

func add_card(card: Dictionary) -> bool:
	if not can_add(card):
		return false
	cards.append(card["id"])
	return true

func remove_card(card_id: String) -> bool:
	if not cards.has(card_id):
		return false
	cards.erase(card_id)
	return true

func shuffle() -> void:
	cards.shuffle()

func draw_top() -> String:
	if cards.is_empty():
		return ""
	return cards.pop_front()

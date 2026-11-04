extends RefCounted

class_name Pocket

const UNCAPPED := -1

var cards: Array = []
var cap: int
var allowed_types: Array = []
var blocked_types: Array = []

func setup(new_cap: int, new_types: Array = [], new_blocked: Array = []) -> void:
	cap = new_cap
	allowed_types = new_types
	blocked_types = new_blocked

func is_full() -> bool:
	if cap == UNCAPPED:
		return false
	return cards.size() >= cap

func accepts_type(card_type: String) -> bool:
	if card_type in blocked_types:
		return false
	if allowed_types.is_empty():
		return true
	return card_type in allowed_types

func can_add(card_type: String) -> bool:
	return not is_full() and accepts_type(card_type)

func add_card(card_id: String, card_type: String) -> bool:
	if not can_add(card_type):
		return false
	cards.append(card_id)
	return true

func remove_card(card_id: String) -> bool:
	if not cards.has(card_id):
		return false
	cards.erase(card_id)
	return true

func shuffle() -> void:
	cards.shuffle()

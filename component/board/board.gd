class_name Board
extends Panel

@onready var slots = $Slots

func get_cards() -> Array[Card]:
	var cards: Array[Card] = []
	for slot in get_slots():
		var card = slot.get_card()
		if card:
			cards.append(card)
	return cards

func get_slots() -> Array[Slot]:
	var slot_nodes: Array[Slot] = []
	slot_nodes.assign(slots.get_children())
	return slot_nodes

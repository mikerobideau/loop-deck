class_name Hand
extends Panel

signal card_drawn(card: Card)

var CardScene = preload("res://component/card/card.tscn")

const HAND_SIZE = 6

@onready var slots = $Slots

var deck: Deck

func deal(n := HAND_SIZE):
	for i in range(n):
		var card = deck.draw()
		var slot = _get_next_available_slot()
		if !slot:
			push_error('Hand Error: draw card did not find an available slot')
			return
		slot.set_card(card)
		card_drawn.emit(card)
		
func get_slots() -> Array[Slot]:
	var slot_nodes: Array[Slot] = []
	slot_nodes.assign(slots.get_children())
	return slot_nodes
	
func _get_next_available_slot():
	for slot in slots.get_children():
		if slot.is_empty():
			return slot

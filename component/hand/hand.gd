class_name Hand
extends Panel

signal card_drawn(card: Card)

var CardScene = preload("res://component/card/card.tscn")

const HAND_SIZE = 7

@onready var slots = $Slots

func deal():
	for i in range(HAND_SIZE):
		_draw_card()
		
func get_slots() -> Array[Slot]:
	var slot_nodes: Array[Slot] = []
	slot_nodes.assign(slots.get_children())
	return slot_nodes
		
func _draw_card():
	var card = CardScene.instantiate()
	card_drawn.emit(card)
	var slot = _get_next_available_slot()
	if !slot:
		push_error('Hand Error: draw card did not find an available slot')
		return
	slot.set_card(card)
	
func _get_next_available_slot():
	for slot in slots.get_children():
		if slot.is_empty():
			return slot

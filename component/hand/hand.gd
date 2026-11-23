class_name Hand
extends Panel

var CardScene = preload("res://component/card/card.tscn")

const HAND_SIZE = 7

@onready var slots = $Slots

func deal():
	for i in range(HAND_SIZE):
		_draw_card()
		
func _draw_card():
	var card = CardScene.instantiate()
	var slot = _get_next_available_slot()
	if !slot:
		push_error('Hand Error: draw card did not find an available slot')
		return
	slot.set_card(card)
	
func _get_next_available_slot():
	for slot in slots.get_children():
		if slot.is_empty():
			print_debug('found slot')
			return slot
		else:
			print_debug('slot is not empty')

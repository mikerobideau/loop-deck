class_name Hand
extends Panel

signal card_drag_started(card: Card)
signal card_drag_ended(card: Card)

var CardScene = preload("res://component/card/card.tscn")

const HAND_SIZE = 7

@onready var slots = $Slots

func deal():
	for i in range(HAND_SIZE):
		_draw_card()
		
func _draw_card():
	var card = CardScene.instantiate()
	card.drag_started.connect(_on_card_drag_started)
	card.drag_ended.connect(_on_card_drag_ended)
	var slot = _get_next_available_slot()
	if !slot:
		push_error('Hand Error: draw card did not find an available slot')
		return
	slot.set_card(card)
	
func _on_card_drag_started(card: Card):
	card_drag_started.emit(card)
	
func _on_card_drag_ended(card: Card):
	card_drag_ended.emit(card)
	
func _get_next_available_slot():
	for slot in slots.get_children():
		if slot.is_empty():
			return slot

class_name Board
extends Panel

@onready var slots = $Slots

var dragged_card: Card
var highlight_slot: Slot = null

func _process(delta: float) -> void:
	if dragged_card:
		_highlight(_get_highlight_slot())
		
func _get_highlight_slot():
	var card_rect = Rect2(dragged_card.global_position, dragged_card.size)
	var best_slot: Slot = null
	var best_area = 0.0
	for slot in slots.get_children():
		if not slot.is_empty():
			continue
		var overlap := card_rect.intersection(slot.get_global_rect())
		var area := overlap.get_area()
		if area > best_area:
			best_area = area
			best_slot = slot
	return best_slot
	
func _highlight(slot: Slot):
	if slot == highlight_slot:
		return
	if highlight_slot:
		highlight_slot.set_highlight(false)
	highlight_slot = slot
	if highlight_slot:
		slot.set_highlight(true)
		
func on_card_drag_started(card: Card):
	dragged_card = card
		
func on_card_drag_ended(card: Card):
	print_debug('board on card drag ended')
	if highlight_slot:
		highlight_slot.set_card(card)
		card.accept_drop()
	else:
		card.return_home()
	_highlight(null)
	dragged_card = null

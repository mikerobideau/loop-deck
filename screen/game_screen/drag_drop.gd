class_name DragDropController
extends Node2D

signal card_moved(card: Card, from_slot: Slot, to_slot: Slot)

var dragged_card: Card
var source_slot: Slot
var highlight_slot: Slot = null
var slots: Array[Slot] = []

func register_slots(new_slots: Array):
	for slot in new_slots:
		slots.append(slot as Slot)
		
func register_card(card: Card):
	card.drag_started.connect(_on_drag_started)
	card.drag_ended.connect(_on_drag_ended)
	
func _process(_delta: float):
	if dragged_card:
		_highlight(_best_slot())
		
func _best_slot():
	var card_rect = Rect2(dragged_card.global_position, dragged_card.size)
	var best_slot: Slot = null
	var best_area = 0.0
	for slot in slots:
		if not slot.is_empty():
			continue
		var area := card_rect.intersection(slot.get_global_rect()).get_area()
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
	
func _on_drag_started(card: Card):
	dragged_card = card
	source_slot = card.get_parent().get_parent() as Slot
	
func _on_drag_ended(card: Card):
	var to_slot := highlight_slot
	_highlight(null)
	var src = source_slot
	dragged_card = null
	source_slot = null
	if to_slot == null:
		card.return_home()
		return
	to_slot.set_card(card)
	card.accept_drop()
	card_moved.emit(card, src, to_slot)

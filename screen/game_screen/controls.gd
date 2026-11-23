class_name Controls
extends Node2D

signal card_moved(card: Card, from_slot: Slot, to_slot: Slot)

var dragged_card: Card
var selected_card: Card
var source_slot: Slot
var highlight_slot: Slot = null
var slots: Array[Slot] = []

func _process(_delta: float):
	if dragged_card:
		_highlight(_best_slot())
	elif selected_card:
		_highlight(_slot_under_mouse())
		var focused := get_viewport().gui_get_focus_owner()
		if focused is Slot and focused.is_empty():
			_highlight(focused)
		else:
			_highlight(_slot_under_mouse())
		
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed('ui_cancel') or event.is_action_pressed('cancel'):
		_select(null)

func register_slots(new_slots: Array):
	for slot in new_slots:
		slots.append(slot as Slot)
		slot.clicked.connect(_on_slot_clicked)
		
func register_card(card: Card):
	card.drag_started.connect(_on_drag_started)
	card.drag_ended.connect(_on_drag_ended)
	card.clicked.connect(_on_card_clicked)
		
func _on_slot_clicked(slot: Slot):
	if selected_card and slot.is_empty():
		var card := selected_card
		_select(null)
		_place(card, card.get_parent().get_parent() as Slot, slot)
		
func _on_card_clicked(card: Card):
	_select(null if card == selected_card else card)
	
func _select(card: Card):
	if selected_card:
		selected_card.set_selected(false)
	selected_card = card
	if selected_card:
		selected_card.set_selected(true)
	else:
		_highlight(null)
		
func _place(card: Card, from_slot: Slot, to_slot: Slot):
	to_slot.set_card(card)
	card.accept_drop()
	card_moved.emit(card, from_slot, to_slot)
	card.grab_focus()
		
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
	
func _slot_under_mouse() -> Slot:
	var mouse_pos = get_global_mouse_position()
	for slot in slots:
		if slot.is_empty() and slot.get_global_rect().has_point(mouse_pos):
			return slot
	return null

func _highlight(slot: Slot):
	if slot == highlight_slot:
		return
	if highlight_slot:
		highlight_slot.set_highlight(false)
	highlight_slot = slot
	if highlight_slot:
		slot.set_highlight(true)
	
func _on_drag_started(card: Card):
	_select(null)
	dragged_card = card
	source_slot = card.get_parent().get_parent() as Slot
	
func _on_drag_ended(card: Card):
	var to_slot := highlight_slot
	_highlight(null)
	var from_slot = source_slot
	dragged_card = null
	source_slot = null
	if to_slot == null:
		card.return_home()
		return
	_place(card, from_slot, to_slot)

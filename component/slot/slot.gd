class_name Slot
extends Panel

signal clicked(slot: Slot)
#signal card_dragged_into_slot(card: Card, slot: Slot)
#signal card_dragged_out_of_slot(card: Card, slot: Slot)

@onready var card_container = $CardContainer

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('click') or event.is_action_pressed('ui_accept'):
		clicked.emit(self)

func set_card(card: Card):
	if get_card() == card:
		return
	if card.get_parent():
		card.reparent(card_container, true)
	else:
		card_container.add_child(card)

func get_card() -> Card:
	return card_container.get_child(0) if card_container.get_child_count() > 0 else null
	
func clear_card():
	for child in card_container.get_children():
		child.queue_free()
		
func is_empty():
	return card_container.get_child_count() == 0

#func _on_mouse_entered() -> void:
#	if DragDrop.is_dragging:
#		print_debug('Card dragged into slot')
#		card_dragged_into_slot.emit()

#func _on_mouse_exited() -> void:
#	if DragDrop.is_dragging:
#		card_dragged_out_of_slot.emit()

func set_highlight(on: bool):
	modulate = Color(1.3, 1.3, 1.3) if on else Color.WHITE

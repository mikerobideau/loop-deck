class_name Slot
extends Panel

signal clicked(slot: Slot)
#signal card_dragged_into_slot(card: Card, slot: Slot)
#signal card_dragged_out_of_slot(card: Card, slot: Slot)

const FOCUS_COLOR = Color.WHITE

@onready var card_container = $CardContainer

func _ready():
	focus_entered.connect(queue_redraw)
	focus_exited.connect(queue_redraw)
	card_container.child_order_changed.connect(_update_focus)
	_update_focus()
	
func _draw():
	if has_focus():
		draw_rect(Rect2(Vector2.ZERO, size), FOCUS_COLOR, false, 4.0)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('click') or event.is_action_pressed('ui_accept') or event.is_action_pressed('select'):
		clicked.emit(self)

func set_card(card: Card):
	if get_card() == card:
		return
	if card.get_parent():
		card.reparent(card_container, true)
	else:
		card_container.add_child(card)
	_update_focus()

func _update_focus():
	focus_mode = Control.FOCUS_ALL if is_empty() else Control.FOCUS_NONE

func get_card() -> Card:
	return card_container.get_child(0) if card_container.get_child_count() > 0 else null
	
func clear_card():
	for child in card_container.get_children():
		child.queue_free()
		
func is_empty():
	return card_container.get_child_count() == 0
	
func set_highlight(on: bool):
	modulate = Color(1.3, 1.3, 1.3) if on else Color.WHITE

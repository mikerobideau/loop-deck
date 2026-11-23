class_name HandSlot
extends Panel

@onready var card_container = $CardContainer

func set_card(card: Card):
	if get_card() == card:
		return
	card_container.add_child(card)

func get_card() -> Card:
	return card_container.get_child(0) if card_container.get_child_count() > 0 else null
	
func clear_card():
	for child in card_container.get_children():
		child.queue_free()
		
func is_empty():
	return card_container.get_child_count() == 0

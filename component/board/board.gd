class_name Board
extends Panel

@onready var slots = $Slots

func get_slots() -> Array[Slot]:
	var slot_nodes: Array[Slot] = []
	slot_nodes.assign(slots.get_children())
	return slot_nodes

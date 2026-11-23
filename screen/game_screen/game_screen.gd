class_name GameScreen
extends Control

@onready var controls = $Controls
@onready var board = $Board
@onready var hand = $Hand

func _ready():
	controls.register_slots(hand.get_slots())
	controls.register_slots(board.get_slots())
	hand.card_drawn.connect(controls.register_card)
	controls.card_moved.connect(_on_card_moved)
	hand.deal()
	hand.get_slots()[0].get_card().grab_focus()

func _on_card_moved(card: Card, from_slot: Slot, to_slot: Slot):
	pass

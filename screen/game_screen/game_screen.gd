class_name GameScreen
extends Control

@onready var drag_drop = $DragDrop
@onready var board = $Board
@onready var hand = $Hand

func _ready():
	drag_drop.register_slots(hand.get_slots())
	drag_drop.register_slots(board.get_slots())
	hand.card_drawn.connect(drag_drop.register_card)
	drag_drop.card_moved.connect(_on_card_moved)
	hand.deal()

func _on_card_moved(card: Card, from_slot: Slot, to_slot: Slot):
	pass

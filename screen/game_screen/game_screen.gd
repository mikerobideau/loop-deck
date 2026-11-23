class_name GameScreen
extends Control

@onready var board = $Board
@onready var hand = $Hand

func _ready():
	hand.deal()
	hand.card_drag_started.connect(_on_card_drag_started)
	hand.card_drag_ended.connect(_on_card_drag_ended)
	
func _on_card_drag_started(card: Card):
	board.on_card_drag_started(card)
	
func _on_card_drag_ended(card: Card):
	board.on_card_drag_ended(card)

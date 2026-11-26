class_name GameScreen
extends Control

@onready var card_manager = $CardManager
@onready var controls = $Controls
@onready var board = $Board
@onready var deck = $Bottom/DeckContainer/Deck
@onready var hand = $Bottom/Hand
#@onready var play_button = $Bottom/ActionContainer/PlayButton

func _ready():
	deck.cards = CardFactory.create_standard_deck()
	controls.register_slots(hand.get_slots())
	controls.register_slots(board.get_slots())
	hand.card_drawn.connect(controls.register_card)
	controls.card_moved.connect(_on_card_moved)
	hand.deck = deck
	hand.deal()
	#hand.get_slots()[0].get_card().grab_focus()

func _on_card_moved(card: Card, from_slot: Slot, to_slot: Slot):
	pass

func _on_play_button_pressed() -> void:
	for card in board.get_cards():
		var effect = card_manager.get_effect(card, board.get_cards(), hand.get_cards(), deck.cards)
		if effect is ScoreEffectResponse:
			print_debug('effect: ' + str(effect.value) + ' ' + str(effect.type))	
		else:
			print_debug('effect is not score effect')

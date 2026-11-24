class_name Deck
extends Panel

var cards: Array[Card]

func draw():
	return cards.pop_front()

class_name CardFactoryGlobal
extends Node

var CardScene = preload("res://component/card/card.tscn")
var StandardDeckData = preload("res://data/deck/standard_deck.tres")

func create_card(data: CardData) -> Card:
	var card = CardScene.instantiate()
	card.data = data
	return card
	
func create_standard_deck() -> Array[Card]:
	var cards: Array[Card] = []
	for data in StandardDeckData.cards:
		cards.append(create_card(data))
	return cards

class_name ConditionContext
extends RefCounted

var card: Card
var played_cards: Array[Card]
var hand: Array[Card]
var deck: Array[Card]

func _init(c: Card, pc: Array[Card], h: Array[Card], d: Array[Card]):
	card = c
	played_cards = pc
	hand = h
	deck = d

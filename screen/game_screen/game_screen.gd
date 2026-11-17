class_name GameScreen
extends Control

@onready var hand = $Hand

func _ready():
	hand.deal()

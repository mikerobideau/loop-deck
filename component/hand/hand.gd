class_name Hand
extends Panel

var CDScene = preload("res://component/cd/cd.tscn")

const HAND_SIZE = 7

@onready var cds = $CDs

func deal():
	for i in range(HAND_SIZE):
		_draw_card()
		
func _draw_card():
	var cd = CDScene.instantiate()
	cds.add_child(cd)

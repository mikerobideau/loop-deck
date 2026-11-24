class_name TooltipGlobal
extends CanvasLayer

@onready var tooltip = $TooltipPanel
var owner_card: Card

func _ready():
	tooltip.hide()

func show_for(card: Card):
	await get_tree().process_frame
	owner_card = card
	tooltip.setup(card.data)
	tooltip.place_near(card.get_global_rect())
	tooltip.show()
	
func hide_for(card: Card):
	if card == owner_card:
		owner_card = null
		tooltip.hide()

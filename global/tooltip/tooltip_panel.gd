class_name TooltipPanel
extends Panel

const GAP := 12.0

@onready var title = $Body/VBoxContainer/Top/Title

func setup(data: CardData):
	title.text = data.name
	
func place_near(card_rect: Rect2):
	var view := get_viewport_rect().size
	var pos := Vector2(card_rect.get_center().x - size.x / 2.0, card_rect.position.y - size.y - GAP)
	if pos.y < 0.0:
		pos.y = card_rect.end.y + GAP
	pos.x = clampf(pos.x, 0.0, view.x - size.x)
	pos.y = clampf(pos.y, 0.0, view.y - size.y)
	position = pos

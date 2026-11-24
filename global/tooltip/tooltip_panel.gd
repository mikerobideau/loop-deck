class_name TooltipPanel
extends Panel

const GAP := 12.0

@onready var title = $Body/VBoxContainer/Top/Title
@onready var rarity_chip = $Body/VBoxContainer/Top/Rarity
@onready var instrument_chip = $Body/VBoxContainer/Chips/Instrument
@onready var role_chip = $Body/VBoxContainer/Chips/Role
@onready var description = $Body/VBoxContainer/DescriptionContainer/Description

func setup(data: CardData):
	title.text = data.name
	rarity_chip.color = Rarity.color_of(data.rarity)
	rarity_chip.text = Rarity.text_of(data.rarity)
	instrument_chip.text = CardData.instrument_text(data.instrument)
	instrument_chip.color = Style.INSTRUMENT_COLOR
	role_chip.text = CardData.role_text(data.role)
	role_chip.color = Style.ROLE_COLOR
	description.text = data.description
	
func place_near(card_rect: Rect2):
	var view := get_viewport_rect().size
	var pos := Vector2(card_rect.get_center().x - size.x / 2.0, card_rect.position.y - size.y - GAP)
	if pos.y < 0.0:
		pos.y = card_rect.end.y + GAP
	pos.x = clampf(pos.x, 0.0, view.x - size.x)
	pos.y = clampf(pos.y, 0.0, view.y - size.y)
	position = pos

class_name Rarity

enum Value {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

const COLORS := {
	Value.COMMON: Color.DARK_CYAN,
	Value.UNCOMMON: Color.BLUE,
	Value.RARE: Color.PURPLE,
	Value.LEGENDARY: Color.GOLDENROD
}

static func color_of(rarity: Rarity.Value) -> Color:
	return COLORS.get(rarity, Color.GRAY)

static func text_of(rarity: Rarity.Value) -> String:
	match rarity:
		Value.COMMON:
			return 'Common'
		Value.UNCOMMON:
			return 'Uncommon'
		Value.RARE:
			return 'Rare'
		Value.LEGENDARY:
			return 'Legendary'
		_:
			return 'Common'

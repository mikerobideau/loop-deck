class_name Rarity

enum Value {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

const COLORS := {
	Value.COMMON: Color.WHITE,
	Value.UNCOMMON: Color.BLUE,
	Value.RARE: Color.PURPLE,
	Value.LEGENDARY: Color.GOLDENROD
}

static func color_of(rarity: Rarity) -> Color:
	return COLORS.get(rarity, Color.GRAY)

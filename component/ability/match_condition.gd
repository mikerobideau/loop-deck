class_name MatchCondition
extends Resource

func find_matches(context: ConditionContext) -> MatchResponse:
	return MatchResponse.new()

func find_previous_cards(context: ConditionContext) -> Array[Card]:
	var cards: Array[Card] = []
	for c in context.played_cards:
		if c == context.card:
			return cards
		cards.append(c)
	return cards
	
func description() -> String:
	return ''

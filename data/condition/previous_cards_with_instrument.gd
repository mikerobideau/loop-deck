class_name PreviousCardsWithInstrument
extends MatchCondition

@export var instrument: CardData.Instrument

func find_matches(context: ConditionContext) -> MatchResponse:
	var response = MatchResponse.new()
	var matches: Array[Card] = []
	for card in find_previous_cards(context):
		if card.data.instrument == instrument:
			matches.append(card)
	response.matches = matches
	return response

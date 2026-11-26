class_name CardManager
extends Node

func get_effect(card: Card, played_cards: Array[Card], hand: Array[Card], deck: Array[Card]) -> EffectResponse:
	var context = get_context(card, played_cards, hand, deck)
	var ability = card.data.ability
	if ability.effect is ScoreEffect:
		return get_score_effect(context)
	else:
		return EffectResponse.new()

func get_context(card: Card, played_cards: Array[Card], hand: Array[Card], deck: Array[Card]) -> ConditionContext:
	return ConditionContext.new(card, played_cards, hand, deck)

func find_matches(context: ConditionContext) -> MatchResponse:
	return context.card.data.ability.match_condition.find_matches(context)
	
func get_score_effect(context: ConditionContext) -> ScoreEffectResponse:
	var ability = context.card.data.ability
	var response = ScoreEffectResponse.new()
	var score_effect = ability.effect
	response.type = score_effect.type
	var total = 0
	if ability.match_condition: #reward for each match
		for match in find_matches(context).matches:
			total += score_effect.value
	else: #flat reward
		total = score_effect.value
	response.value = total
	return response

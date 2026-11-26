class_name CardManager
extends Node

func get_effect(card: Card, played_cards: Array[Card], hand: Array[Card], deck: Array[Card]) -> RewardResponse:
	var context = get_context(card, played_cards, hand, deck)
	return get_reward(context)

func get_context(card: Card, played_cards: Array[Card], hand: Array[Card], deck: Array[Card]) -> ConditionContext:
	return ConditionContext.new(card, played_cards, hand, deck)

func find_matches(context: ConditionContext) -> MatchResponse:
	return context.card.data.ability.match_condition.find_matches(context)
	
func get_reward(context: ConditionContext) -> RewardResponse:
	var ability = context.card.data.ability
	var reward_response = RewardResponse.new()
	var reward = ability.reward
	reward_response.type = reward.type
	var total = 0
	if ability.match_condition: #reward for each match
		var match_response = find_matches(context)
		for match in match_response.matches:
			total += reward.value
	else: #flat reward
		total = reward.value
	reward_response.value = total
	return reward_response

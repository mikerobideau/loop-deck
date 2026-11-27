class_name Ability
extends Resource

@export var active_condition: ActiveCondition
@export var match_condition: MatchCondition
@export var effect: Effect

func description() -> String:
	var parts: Array[String] = []
	if active_condition is not Always:
		parts.append(active_condition.description() + ',')
	parts.append(effect.description())
	if match_condition:
		parts.append(match_condition.description())
	return ' '.join(parts)

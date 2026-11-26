class_name Reward
extends Resource

enum Type {
	POINTS,
	MULT
}

@export var type: Type
@export var value: int

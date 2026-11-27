class_name ScoreEffect
extends Effect

enum Type {
	POINTS,
	MULT
}

@export var type: Type
@export var value: int

static func type_text(value: Type) -> String:
	return str(Type.find_key(value)).to_lower()
	
func description() -> String:
	return '+' + str(value) + ' ' + type_text(type)

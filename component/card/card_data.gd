class_name CardData
extends Resource

enum Role {
	PERCUSSION,
	BASS,
	RHYTHM,
	LEAD
}

enum Instrument {
	DRUMS,
	ELECTRIC_BASS,
	SYNTH_BASS,
	ELECTRIC_GUITAR,
	ACOUSTIC_GUITAR,
	SYNTH,
	PIANO,
	SAXAPHONE
}

@export var name: String
@export var role: Role
@export var instrument: Instrument
@export var description: String
@export var rarity: Rarity.Value

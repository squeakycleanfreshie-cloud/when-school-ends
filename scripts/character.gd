class_name Character
extends Node

enum Name {
	CHLOE,
	FINN,
	HUGO,
	MIA,
	OAKLEY,
	NARR
}

const CHARACTER_DETAILS : Dictionary = {
	Name.CHLOE: {
		"name": "Chloe",
		"gender": "female",
		"sprite_frames": preload("res://spriteframes/chloe.tres")
	},
	Name.FINN: {
		"name": "Finn",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/finn.tres")
	},
	Name.HUGO: {
		"name": "Hugo",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/hugo.tres")
	},
	Name.MIA: {
		"name": "Mia",
		"gender": "female",
		"sprite_frames": preload("res://spriteframes/mia.tres")
	},
	Name.OAKLEY: {
		"name": "Oakley",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/oakley.tres")
	},
	Name.NARR: {
		"name": "Narrarator",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/narrarator.tres")
		}
}

static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if Name.has(upper_string):
		return Name[upper_string]
	else:
		push_error("Invalid Character Name: " + string_value)
		return -1

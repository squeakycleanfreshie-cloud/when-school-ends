class_name Character
extends Node

# list the character string
enum Name {
	CHLOE,
	FINN,
	HUGO,
	MIA,
	OAKLEY,
	NARRARATOR,
	BARISTA,
	BIO,
	PRINCIPAL,
	SPORT
}


# gives us the character details and spriteframes
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
	Name.NARRARATOR: {
		"name": "Narrarator",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/narrarator.tres")
	},
	Name.BARISTA: {
		"name": "Barista",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/narrarator.tres")
	},
	Name.BIO: {
		"name": "Mr.Song",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/bio_teacher.tres")
	},
	Name.PRINCIPAL: {
		"name": "Ms Henderson",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/principal.tres")
	},
	Name.SPORT: {
		"name": "Mr Cross",
		"gender": "male",
		"sprite_frames": preload("res://spriteframes/sports.tres")
	}
}

static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()


	if Name.has(upper_string):
		return Name[upper_string]


	for key in CHARACTER_DETAILS:
		if CHARACTER_DETAILS[key]["name"].to_upper() == upper_string:
			return key

	push_error("Invalid Character Name: " + string_value)
	return -1

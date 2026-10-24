extends AudioStreamPlayer

const sounds : Dictionary = {
	"male": preload("res://assets/sounds/sfx/male_cut.mp3"),
	"female": preload("res://assets/sounds/sfx/female_cut.mp3")
}

func play_sound(character_details: Dictionary):
	var character_gender = character_details["gender"]
	stream = sounds[character_gender]
	play()

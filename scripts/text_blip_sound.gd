extends AudioStreamPlayer

const sounds : Dictionary = {
	"male": preload("res://assets/sounds/sfx/male.mp3"),
	"female": preload("res://assets/sounds/sfx/female.mp3")
}

func play_sound(character_details: Dictionary):
	stream = sounds[character_details["gender"]]
	play()

extends Node

var current_experience = 0

func _ready():
	GameEvents.experience_orb_collected.connect(increment_experience)

func increment_experience(gained_experience: float):
	current_experience += gained_experience
	print(current_experience)

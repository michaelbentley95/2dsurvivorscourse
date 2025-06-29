extends Node

signal experience_orb_collected(collected_experience: float)

func emit_experience_orb_collected(number: float):
	experience_orb_collected.emit(number)

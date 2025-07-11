extends Node
class_name ExperienceManager

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience = 0
var current_level = 1
var target_experience = 1

func _ready():
	GameEvents.experience_orb_collected.connect(increment_experience)

func increment_experience(gained_experience: float):
	current_experience = min(current_experience + gained_experience, target_experience)
	if current_experience == target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_experience = 0
		level_up.emit(current_level)
	experience_updated.emit(current_experience, target_experience)

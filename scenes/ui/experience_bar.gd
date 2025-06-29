extends CanvasLayer

@onready var progress_bar = $MarginContainer/ProgressBar

@export var experience_manager: ExperienceManager

func _ready():
	experience_manager.experience_updated.connect(on_experience_updated)

func on_experience_updated(current_experience: float, target_experience: float): 
	progress_bar.value = current_experience / target_experience

extends Node2D


func _ready() -> void:
	$Area2D.area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	GameEvents.emit_experience_orb_collected(1)
	queue_free()

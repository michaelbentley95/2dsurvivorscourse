extends Node

@export_range(0,1) var drop_percent: float = .5
@export var health_component: Node
@export var orb_scene: PackedScene

func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	
func on_died():
	if randf()>drop_percent:
		return
	
	#check that everything is right
	if orb_scene == null:
		return
	if not owner is Node2D:
		return
	#get the position of the dead
	var spawn_position = (owner as Node2D).global_position
	#create the orb
	var orb_instance = orb_scene.instantiate() as Node2D
	owner.get_parent().add_child(orb_instance)
	orb_instance.global_position = spawn_position

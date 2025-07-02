extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

@onready var invincibility_frames_timer = $InvincibilityFramesTimer
@onready var health_component = $HealthComponent

var number_colliding_bodies = 0

func _ready() -> void:
	$HurtCollisionArea2D.body_entered.connect(on_body_entered)
	$HurtCollisionArea2D.body_exited.connect(on_body_exited)
	invincibility_frames_timer.timeout.connect(check_deal_damage)
	health_component.health_changed.connect(on_health_changed)
	on_health_changed() #call at the beginning to instantiate the healthbar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()

func get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)

func check_deal_damage():
	if number_colliding_bodies == 0 || !invincibility_frames_timer.is_stopped():
		return
	health_component.damage(1)
	invincibility_frames_timer.start()
	print(health_component.current_health)

func on_body_entered(other_body: Node2D) -> void:
	number_colliding_bodies += 1
	check_deal_damage()
	return
	

func on_body_exited(other_body: Node2D) -> void:
	number_colliding_bodies -= 1
	return
	
func on_health_changed() -> void:
	$HealthBar.value = health_component.get_health_percent()
	return

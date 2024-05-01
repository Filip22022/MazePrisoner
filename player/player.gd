class_name Player
extends CharacterBody2D

signal health_depleted

@onready var dash = $dash_timer
const dash_length = 0.5

func _physics_process(delta):
	
	if ! is_dashing():
		if Input.is_action_just_pressed("Dash"):
			start_dash()
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * PlayerInfo.speed
	if is_dashing():
		velocity *= 5 * pow(dash.time_left,1)
	move_and_slide()
	
			
func take_damage(amount: float):
	_change_health(-amount)
	
func heal(amount: float):
	_change_health(amount)
	
func _change_health(amount: float):
	PlayerInfo.health += amount
	%HealthBar.value = PlayerInfo.health
	if PlayerInfo.health <= 0.0:
		health_depleted.emit()
	
func change_speed(amount: float):
	PlayerInfo.speed += amount
	if PlayerInfo.speed < 50.0:
		PlayerInfo.speed = 50.0
		
func change_player_damage(amount: float):
	PlayerInfo.damage += amount
	if PlayerInfo.damage < 0.1:
		PlayerInfo.damage = 0.1

func start_dash():
	dash.wait_time = dash_length
	dash.start()
	
func is_dashing():
	return !dash.is_stopped()

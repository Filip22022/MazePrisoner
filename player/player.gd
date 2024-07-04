class_name Player
extends CharacterBody2D

signal health_depleted

@onready var dash = $dash_timer
const dash_length = 0.5
@onready var max_health: float = PlayerInfo.get_stat(PlayerInfo.StatNames.health)
@onready var current_health = max_health
@onready var animation_player = $AnimationPlayer

func _init():
	PlayerInfo.player_reference = self
	PlayerInfo.stats_changed.connect(update_stats)

func _physics_process(delta):
	
	if ! is_dashing():
		if Input.is_action_just_pressed("Dash"):
			start_dash()
	
	var direction
	if (Input.is_action_pressed("move_right")):
		animation_player.play("run_right")
	elif (Input.is_action_pressed("move_left")):
		animation_player.play("run_left")
	elif (Input.is_action_pressed("move_down")):
		animation_player.play("run_down")
	elif (Input.is_action_pressed("move_up")):
		animation_player.play("run_up")
	#if (!_isMoving()):
	else:
		animation_player.play("idle")
	
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = direction * PlayerInfo.get_stat_value(PlayerInfo.StatNames.speed)
	if is_dashing():
		self.velocity *= 5 * pow(dash.time_left,1)
	move_and_slide()
	
func _isMoving():
	if (Input.is_action_pressed("move_right")):
		return true
	if (Input.is_action_pressed("move_left")):
		return true
	if (Input.is_action_pressed("move_down")):
		return true
	if (Input.is_action_pressed("move_up")):
		return true
	return false
	
func update_stats():
	self.max_health = PlayerInfo.get_stat_value(PlayerInfo.StatNames.health)
			
func take_damage(amount: float):
	_change_health(-amount)
	
func heal(amount: float):
	_change_health(amount)
	
func _change_health(amount: float):
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	%HealthBar.value = current_health
	
	if current_health <= 0.0:
		health_depleted.emit()
		GameState.maze_size = 3
		PlayerInfo.restart()

func start_dash():
	dash.wait_time = dash_length
	dash.start()
	
func is_dashing():
	return !dash.is_stopped()

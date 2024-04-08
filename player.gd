extends CharacterBody2D

signal health_depleted

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * PlayerInfo.speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
		const DAMAGE_RATE = 15.0
		var overlapping_mobs = %HurtBox.get_overlapping_bodies()
		if overlapping_mobs.size() > 0:
			take_damage(DAMAGE_RATE * overlapping_mobs.size() * delta)
			
				
func take_damage(amount: float):
	_change_health(-amount)
	
func heal(amount: float):
	_change_health(amount)
	
func _change_health(amount: float):
	PlayerInfo.health += amount
	%HealthBar.value = PlayerInfo.health
	if PlayerInfo.health <= 0.0:
		health_depleted.emit()
	


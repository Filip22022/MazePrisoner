class_name Enemy
extends CharacterBody2D


var health: float

func take_damage(damage: float):
	self.health -= damage
	if health <= 0.0:
		die()
		

func die():
	GameState.many_enemies -= 1
	var ani = $AnimatedSprite2D
	set_process(false)
	print(ani)
	if ani != null:
		ani.play("Dead")
		await get_tree().create_timer(0.8).timeout
	queue_free()

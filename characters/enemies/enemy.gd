class_name Enemy
extends CharacterBody2D

signal enemydie

var health: float

func take_damage(damage: float):
	self.health -= damage
	if health <= 0.0:
		die()
		

func die():
	GameState.many_enemies -= 1
	queue_free()

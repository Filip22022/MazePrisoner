class_name Enemy
extends CharacterBody2D

var health: float

func take_damage(damage: float):
	self.health -= damage
	if health <= 0.0:
		die()
		

func die():
	queue_free()

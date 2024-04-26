extends Node2D

var health: float

func _init():
	self.health = 100

func take_damage(damage: float):
	self.health -= damage
	if health <= 0.0:
		die()
		
func die():
	queue_free()

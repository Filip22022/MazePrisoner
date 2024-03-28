class_name Hitbox
extends Area2D


@export var damage := 10

func _init() -> void:
	collision_layer = 2
	collision_mask = 0

		
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)

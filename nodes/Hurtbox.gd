class_name Hurtbox
extends Area2D


func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	print(hitbox.get_parent().name)
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)


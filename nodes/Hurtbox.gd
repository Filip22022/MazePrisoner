class_name Hurtbox
extends Area2D


func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	print(hitbox.get_parent().name)
	if owner.has_method("take_damage"):
		if hitbox.get_parent().name == 'Sprite2D':
			var dmg = PlayerInfo.get_stat_value(PlayerInfo.StatNames.damage)
			owner.take_damage(dmg)
		else:
			owner.take_damage(hitbox.damage * round((GameState.maze_size / 3)))


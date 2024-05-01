class_name PlayerManager
extends Node2D

signal player_death

var player: Player

func spawn_player(player_position):
	if not self.has_node("Player"):
		if not self.player:
			_create_player()
		else:
			add_child(self.player)
	
	player.position = player_position
	
func _create_player():
	var p = load("res://player/player.tscn")
	self.player = p.instantiate()
	add_child(player)
	player.health_depleted.connect(func(): player_death.emit())

func reset_player():
	player.heal(100.0)
	
func remove_player():
	if self.player:
		remove_child(self.player)

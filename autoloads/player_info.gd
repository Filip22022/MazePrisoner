extends Node

var player_reference: Player

var health: float = 100.0
var speed: float = 300.0
var damage: float = 5.0

func get_player():
	if self.player_reference:
		return player_reference
	else:
		push_error("The player is missing...")

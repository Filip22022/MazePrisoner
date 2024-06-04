class_name PlayerManager
extends Node2D

signal player_death

var player: Player

func _init():
	_create_player()

func _ready():
	var reference = PlayerInfo.get_player()
	if reference == null:
		_create_player()
	else:
		self.player = reference

func spawn_player(player_position):
	if not self.has_node("Player"):
		add_child(self.player)
	
	player.position = player_position
	
func _create_player():
	self.player = load("res://player/player.tscn").instantiate()
	self.player.health_depleted.connect(func(): player_death.emit())

func reset_player():
	self.player.heal(100.0)
	
func remove_player():
	if self.player:
		remove_child(self.player)

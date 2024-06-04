extends Node2D

@onready var interaction_area = $InteractionArea
@export var upgraded_stat: PlayerInfo.StatNames

func _ready():
	interaction_area.interact = Callable(self, "_buy_upgrade")
	
func _buy_upgrade():
	print("stat: " + PlayerInfo.StatNames.keys()[upgraded_stat])
	print("old_value: " + str(PlayerInfo.get_stat(upgraded_stat)))
	PlayerInfo.upgrade(upgraded_stat)
	print("new_value: " + str(PlayerInfo.get_stat(upgraded_stat)))
	

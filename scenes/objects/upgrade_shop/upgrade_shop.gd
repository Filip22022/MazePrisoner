extends Node2D

@onready var interaction_area = $InteractionArea
@export var upgraded_stat: PlayerInfo.StatNames

func _ready():
	interaction_area.interact = Callable(self, "_buy_upgrade")
	
func _buy_upgrade():
	if PlayerInfo.get_coins() > 0:
		PlayerInfo.pay_coins(1)
		PlayerInfo.upgrade(upgraded_stat)
	

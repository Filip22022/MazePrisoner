extends Node

signal stats_changed

var player_reference: Player

var coins = 0

enum  StatNames {
	health,
	speed,
	damage,
}

var Stats = {
	StatNames.health: {"base_value": 10, "current_value": 10, "multiplier": 10},
	StatNames.speed: {"base_value": 10, "current_value": 10, "multiplier": 30},
	StatNames.damage: {"base_value": 10, "current_value": 10, "multiplier": 1},
}

func restart():
	for stat_name in StatNames.values():
		Stats[stat_name]["current_value"] = Stats[stat_name]["base_value"]
	coins = 0

func get_player():
	if self.player_reference:
		return player_reference
	else:
		push_error("The player is missing...")
		return null
		
func get_stat_value(stat_name: StatNames):
	return Stats[stat_name]["current_value"] * Stats[stat_name]["multiplier"]

func get_stat(stat_name: StatNames):
	return Stats[stat_name]["current_value"]

func upgrade(stat_name: StatNames):
	if Stats.has(stat_name):
		Stats[stat_name]["current_value"] += 1
	stats_changed.emit()
		
func downgrade(stat_name: StatNames):
	if Stats.has(stat_name):
		Stats[stat_name]["current_value"] -= 1
	stats_changed.emit()
		
func get_coins():
	return coins

func earn_coins(amount: int):
	coins += amount
	
func pay_coins(amount: int):
	coins -= amount

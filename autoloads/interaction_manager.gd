extends Node

@onready var player = PlayerInfo.get_player()

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas[index].hide_label()
		active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		get_tree().call_group("InteractionAreas", "hide_label")
		active_areas[0].show_label()
		
func _sort_by_distance_to_player(area1, area2):
	var distance1 = player.global_position.distance_to(area1.global_position)
	var distance2 = player.global_position.distance_to(area2.global_position)
	return distance1 < distance2

func _input(event):
	if event.is_action_pressed("Interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			
			await active_areas[0].interact.call()
			
			can_interact = true

class_name Scene
extends Node2D

signal scene_change_requested(path: String, direction: Room_Directions.Direction)

var entered_from: Room_Directions.Direction

func spawn_player():
	var p = load("res://player.tscn")
	var player = p.instantiate()
	player.position = $PlayerSpawn.position
	add_child(player)

func _on_transition_area_transition_entered(new_scene_path: String, direction: Room_Directions.Direction):
	scene_change_requested.emit(new_scene_path, direction)


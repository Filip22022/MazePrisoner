class_name Scene
extends Node2D

signal room_change_requested(direction: Directions.Direction)
signal scene_change_requested(scene_path: String)

var entered_from: Directions.Direction

func initialize(entered_from: Directions.Direction, connections: Dictionary):
	self.entered_from = entered_from

func _on_transition_area_transition_entered(direction: Directions.Direction):
	room_change_requested.emit(direction)


func request_scene_change(scene_path: String):
	scene_change_requested.emit(scene_path)
	

func get_player_spawn():
	match self.entered_from:
		Directions.Direction.Up:
			if self.has_node("PlayerSpawnTop"):
				var spawn: Marker2D = self.get_node("PlayerSpawnTop")
				return spawn.global_position
		Directions.Direction.Right:
			if self.has_node("PlayerSpawnRight"):
				var spawn: Marker2D = self.get_node("PlayerSpawnRight")
				return spawn.global_position
		Directions.Direction.Down:
			if self.has_node("PlayerSpawnDown"):
				var spawn: Marker2D = self.get_node("PlayerSpawnDown")
				return spawn.global_position
		Directions.Direction.Left:
			if self.has_node("PlayerSpawnLeft"):
				var spawn: Marker2D = self.get_node("PlayerSpawnLeft")
				return spawn.global_position

#func spawn_exit():
	#var exit = load("res://scenes/objects/exit/maze_exit.tscn").instantiate()
	#self.add_child(exit)
	#exit.position = Vector2i(0,0)

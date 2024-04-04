class_name Scene
extends Node2D

signal scene_change_requested(path: String, direction: Room_Directions.Direction)

var entered_from: Room_Directions.Direction
	
func initialize(connections: Dictionary = {}):
	if len(connections) > 0:
		self.set_connections(connections)

func _on_transition_area_transition_entered(new_scene_path: String, direction: Room_Directions.Direction):
	scene_change_requested.emit(new_scene_path, direction)

func set_connections(connections: Dictionary):
	for side in connections.keys():
		match side:
			Room_Directions.Direction.Up:
				if self.has_node("TransitionAreaTop"):
					var transition: TransitionArea = self.get_node("TransitionAreaTop")
					transition.destination_path = connections[side].room_scene_path
			Room_Directions.Direction.Right:
				if self.has_node("TransitionAreaRight"):
					var transition: TransitionArea = self.get_node("TransitionAreaRight")
					transition.destination_path = connections[side].room_scene_path
			Room_Directions.Direction.Down:
				if self.has_node("TransitionAreaDown"):
					var transition: TransitionArea = self.get_node("TransitionAreaDown")
					transition.destination_path = connections[side].room_scene_path
			Room_Directions.Direction.Left:
				if self.has_node("TransitionAreaLeft"):
					var transition: TransitionArea = self.get_node("TransitionAreaLeft")
					transition.destination_path = connections[side].room_scene_path
			

func get_player_spawn():
	match self.entered_from:
		Room_Directions.Direction.Up:
			if self.has_node("PlayerSpawnTop"):
				var spawn: Marker2D = self.get_node("PlayerSpawnTop")
				return spawn.global_position
		Room_Directions.Direction.Right:
			if self.has_node("PlayerSpawnRight"):
				var spawn: Marker2D = self.get_node("PlayerSpawnRight")
				return spawn.global_position
		Room_Directions.Direction.Down:
			if self.has_node("PlayerSpawnDown"):
				var spawn: Marker2D = self.get_node("PlayerSpawnDown")
				return spawn.global_position
		Room_Directions.Direction.Left:
			if self.has_node("PlayerSpawnLeft"):
				var spawn: Marker2D = self.get_node("PlayerSpawnLeft")
				return spawn.global_position

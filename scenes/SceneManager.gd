class_name SceneManager
extends Node2D

var current_scene: Scene = null

func _init():
	change_scene("res://scenes/rooms/room1.tscn", Room_Directions.Direction.Down)

func change_scene(scene_path: String, direction: Room_Directions.Direction):
	call_deferred("_deferred_change_scene", scene_path, direction)

func _deferred_change_scene(scene_path: String, direction: Room_Directions.Direction):
	if current_scene:
		current_scene.scene_change_requested.disconnect(change_scene)
		remove_child(current_scene)
		current_scene.free()
	
	current_scene = load(scene_path).instantiate()
	add_child(current_scene)
	
	current_scene.scene_change_requested.connect(change_scene)
	current_scene.entered_from = Room_Directions.opposite(direction)
	%Player.position = current_scene.get_player_spawn()
#
#func change_room();
	#change_scene(room)
	#current_scene.initialize(room.connections)

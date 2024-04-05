class_name SceneManager
extends Node2D


var current_scene: Scene = null
var rooms = []
var current_room: MazeRoom
var player

func _ready():
	#change_scene("res://scenes/rooms/room15.tscn", Room_Directions.Direction.Down)
	current_scene = $StartMenu
	current_scene.scene_change_requested.connect(start_game)
	self.rooms = $MazeGenerator.generate_maze()
	self.current_room = $MazeGenerator.get_starting_room()

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
	spawn_player(current_scene.get_player_spawn())
	
func start_game(scene_path: String, direction: Room_Directions.Direction):
	var path = self.current_room.get_scene_path()
	change_scene(path, direction)
	call_deferred("spawn_player")
	
func spawn_player(position):
	if not self.player:
		create_player()
	player.position = position
	
func create_player():
	var p = load("res://player.tscn")
	self.player = p.instantiate()
	add_child(player)
#
#func change_room();
	#change_scene(room)
	#current_scene.initialize(room.connections)
	#if current_scene.is_final:
		#room.place_exit()

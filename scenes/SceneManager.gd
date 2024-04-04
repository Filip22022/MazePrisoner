class_name SceneManager
extends Node2D


var current_scene: Scene = null
var rooms = []
var start: MazeRoom

func _ready():
	#change_scene("res://scenes/rooms/room15.tscn", Room_Directions.Direction.Down)
	current_scene = $StartMenu
	current_scene.scene_change_requested.connect(start_game)
	self.rooms = $MazeGenerator.generate_maze()
	self.start = $MazeGenerator.get_starting_room()

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
	if %Player:
		%Player.position = current_scene.get_player_spawn()
	
func start_game(scene_path: String, direction: Room_Directions.Direction):
	var path = self.start.get_scene_path()
	print(path)
	path = path if path else scene_path
	change_scene(path, direction)
	call_deferred("spawn_player")
	
	
func spawn_player():
	var p = load("res://player.tscn")
	var player = p.instantiate()
	player.position = current_scene.get_player_spawn()
	add_child(player)
#
#func change_room();
	#change_scene(room)
	#current_scene.initialize(room.connections)
	#if current_scene.is_final:
		#room.place_exit()

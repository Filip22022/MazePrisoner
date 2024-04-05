class_name SceneManager
extends Node2D


var current_scene: Scene = null
var rooms = []
var current_room: MazeRoom
var player

func _ready():
	current_scene = $StartMenu
	current_scene.start_game.connect(start_game)
	
func change_room(direction: Directions.Direction):
	call_deferred("_deferred_change_room", direction)
	
func _deferred_change_room(direction: Directions.Direction):
	var new_room = current_room.connected_rooms[direction]
	self.current_room = new_room
	
	_deferred_change_scene()
	
	self.current_scene.initialize(Directions.opposite(direction))
	spawn_player(self.current_scene.get_player_spawn())
	
	
func deferred_change_scene():
	call_deferred("_deferred_change_scene")

func _deferred_change_scene():
	if current_scene:
		current_scene.room_change_requested.disconnect(change_room)
		remove_child(current_scene)
		current_scene.free()
		
	current_scene = load(current_room.get_scene_path()).instantiate()
	add_child(current_scene)
	
	current_scene.room_change_requested.connect(change_room)
	
	
func start_game():
	self.rooms = $MazeGenerator.generate_maze()
	var starting_room: MazeRoom = $MazeGenerator.get_starting_room()
	starting_room.room_scene_path = "res://scenes/start_room/start_room.tscn"
	self.current_room = starting_room
	deferred_change_scene()
	call_deferred("_deferred_start_game")
	
func _deferred_start_game():
	self.current_scene.open_doors(self.current_room.connected_rooms)
	spawn_player(self.current_scene.get_player_spawn())
	
func spawn_player(player_position):
	if not self.player:
		_create_player()
	player.position = player_position
	
func _create_player():
	var p = load("res://player.tscn")
	self.player = p.instantiate()
	add_child(player)

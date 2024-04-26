class_name SceneManager
extends Node2D


var current_scene: Scene = null
var rooms = []
var current_room: MazeRoom
var player

func _ready():
	current_scene = $StartMenu
	
func change_room(direction: Directions.Direction):
	call_deferred("_deferred_change_room", direction)
	
func _deferred_change_room(direction: Directions.Direction):
	var new_room = current_room.connected_rooms[direction]
	self.current_room = new_room
	
	_deferred_change_scene(self.current_room.get_scene_path())
	
	
	if self.current_room.is_final:
		self.current_scene.spawn_exit()
	
	self.current_scene.initialize(Directions.opposite(direction), self.current_room.connected_rooms)
	spawn_player(self.current_scene.get_player_spawn())
	
	
func deferred_change_scene(scene_path: String):
	call_deferred("_deferred_change_scene", scene_path)

func _deferred_change_scene(scene_path: String):
	if self.current_scene:
		self.current_scene.room_change_requested.disconnect(change_room)
		self.current_scene.scene_change_requested.disconnect(deferred_change_scene)
		remove_child(current_scene)
		current_scene.free()
	if self.player:
		remove_child(self.player)
			
	current_scene = load(scene_path).instantiate()
	add_child(current_scene)
	
	self.current_scene.room_change_requested.connect(change_room)
	self.current_scene.scene_change_requested.connect(deferred_change_scene)
	
	
func start_game():
	self.rooms = $MazeGenerator.generate_maze()
	var starting_room: MazeRoom = $MazeGenerator.get_starting_room()
	starting_room.room_scene_path = "res://scenes/rooms/start_room/start_room.tscn"
	self.current_room = starting_room
	deferred_change_scene(self.current_room.room_scene_path)
	call_deferred("_deferred_start_game")
	
func _deferred_start_game():
	spawn_player(self.current_scene.get_player_spawn())
	self.current_scene.initialize(Directions.Direction.Up, self.current_room.connected_rooms)
	
func spawn_player(player_position):
	if not self.has_node("Player"):
		if not self.player:
			_create_player()
		else:
			add_child(self.player)
	
	player.position = player_position
	
	
func _create_player():
	var p = load("res://player/player.tscn")
	self.player = p.instantiate()
	add_child(player)

class_name SceneManager
extends Node2D

signal game_over

var current_scene: Scene = null
var rooms = []
var current_room: MazeRoom
@onready var player_manager = $PlayerManager

func _ready():
	current_scene = $StartMenu
	player_manager.player_death.connect(func(): game_over.emit())
	
func end_game():
	_deferred_change_scene("res://scenes/menus/start_menu.tscn")
	current_scene.start_game.connect(self.get_parent().start_game)
	player_manager.reset_player()
	
	
func change_room(direction: Directions.Direction):
	call_deferred("_deferred_change_room", direction)
	#TODO refactor to Callable.call_deferred(args)
	
func _deferred_change_room(direction: Directions.Direction):
	var new_room = current_room.connected_rooms[direction]
	self.current_room = new_room
	
	_deferred_change_scene(self.current_room.get_scene_path())
	
	
	if self.current_room.is_final:
		self.current_scene.game_won.connect(func(): game_over.emit())
	
	self.current_scene.initialize(Directions.opposite(direction), self.current_room.connected_rooms)
	player_manager.spawn_player(self.current_scene.get_player_spawn())
	
	
func deferred_change_scene(scene_path: String):
	call_deferred("_deferred_change_scene", scene_path)

func _deferred_change_scene(scene_path: String):
	if self.current_scene:
		self.current_scene.room_change_requested.disconnect(change_room)
		self.current_scene.scene_change_requested.disconnect(deferred_change_scene)
		remove_child(current_scene)
		current_scene.queue_free()
		player_manager.remove_player()
			
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
	player_manager.spawn_player(self.current_scene.get_player_spawn())
	self.current_scene.initialize(Directions.Direction.Up, self.current_room.connected_rooms)

class_name SceneManager
extends Node2D

signal run_ended
signal run_started

var _current_scene: Scene = null
var _rooms = []
var _current_room: MazeRoom
@onready var _player_manager = $PlayerManager


func _ready():
	_current_scene = $StartMenu
	_player_manager.player_death.connect(func(): run_ended.emit())
	
func start_game():
	_enter_hub()
	
	
func start_run_deferred():
	call_deferred("_start_run")
	
func _start_run():
	GameState.start_run()
	
	_rooms = $MazeGenerator.generate_maze()
	var starting_room: MazeRoom = $MazeGenerator.get_starting_room()
	_current_room = starting_room
	
	_change_scene(_current_room.get_room_scene())
	
	_player_manager.spawn_player(_current_scene.get_player_spawn())
	_current_scene.initialize(Directions.Direction.Up)
	_current_scene.open_doors()
	
func end_game():
	_change_scene(load("res://scenes/menus/start_menu.tscn").instantiate())
	_current_scene.start_game.connect(self.get_parent().start_game)
	_player_manager.reset_player()
	
func end_run():
	call_deferred("_enter_hub")
	
func _deferred_change_room(direction: Directions.Direction):
	call_deferred("_change_room", direction)
	
func _change_room(direction: Directions.Direction):
	var new_room = _current_room.connected_rooms[direction]
	_current_room = new_room
	
	_change_scene(_current_room.get_room_scene())
	
	if _current_room.is_final:
		_current_scene.game_won.connect(func(): run_ended.emit())
	
	_current_scene.initialize(Directions.opposite(direction))
	_current_scene.open_doors()
	_player_manager.spawn_player(_current_scene.get_player_spawn())
	
func _deferred_change_scene(scene: Scene):
	call_deferred("_change_scene", scene)

func _change_scene(scene: Scene):
	if _current_scene:
		_current_scene.room_change_requested.disconnect(_deferred_change_room)
		_current_scene.scene_change_requested.disconnect(_deferred_change_scene)
		remove_child(_current_scene)
		_player_manager.remove_player()
			
	_current_scene = scene
	add_child(_current_scene)
	
	_current_scene.room_change_requested.connect(_deferred_change_room)
	_current_scene.scene_change_requested.connect(_deferred_change_scene)
	
func _enter_hub():
	var hub_room_scene = load("res://scenes/hub_room/hub_room.tscn").instantiate()
	hub_room_scene.run_started.connect(func(): run_started.emit())
	_change_scene(hub_room_scene)
	_player_manager.spawn_player(_current_scene.get_player_spawn())
	

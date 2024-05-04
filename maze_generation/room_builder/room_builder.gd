class_name RoomBuilder
extends Node2D

var room_height = 320
var room_width = 480
var room

func _init():
	build([1,2])
	var player = load("res://player/player.tscn").instantiate()
	add_child(player)
	add_child(room)

func build(directions: Array[Directions.Direction]):
	room = load("res://maze_generation/room_builder/empty_room.tscn").instantiate()
	
	build_walls(directions)
	add_player_spawns(directions)
	return room
	
	
func build_walls(open_directions: Array[Directions.Direction]):
	var walls = {}
	walls[Directions.Direction.Up] = {
			"path": "res://maze_generation/room_builder/walls/top_wall_", 
			"position": Vector2i(0, -room_height/2)
		}
	walls[Directions.Direction.Right] = {
			"path": "res://maze_generation/room_builder/walls/right_wall_", 
			"position": Vector2i(room_width/2,0)
		}
	walls[Directions.Direction.Down] = {
			"path": "res://maze_generation/room_builder/walls/down_wall_", 
			"position": Vector2i(0, room_height/2)
		}
	walls[Directions.Direction.Left] = {
			"path": "res://maze_generation/room_builder/walls/left_wall_", 
			"position": Vector2i(-room_width/2,0)
		}
	
	for dir in Directions.Direction.values():
		if dir in open_directions:
			walls[dir]["path"] += "open.tscn"
		else:
			walls[dir]["path"] += "closed.tscn"
			
	for wall in walls.values():
		var current_wall = load(wall["path"]).instantiate()
		current_wall.global_position = wall["position"]
		self.room.add_child(current_wall)
	
func add_player_spawns(open_directions: Array[Directions.Direction]):
	var spawns = {}
	
	for dir in open_directions:
		var spawn = Marker2D.new()
		match dir:
			Directions.Direction.Up:
				spawn.global_position = Vector2i(0, -(room_height/2-32))
				spawn.set_name("PlayerSpawnTop")
			Directions.Direction.Right:
				spawn.global_position = Vector2i((room_width/2-32),0)
				spawn.set_name("PlayerSpawnRight")
			Directions.Direction.Right:
				spawn.global_position = Vector2i(0, room_height/2-32)
				spawn.set_name("PlayerSpawnDown")
			Directions.Direction.Right:
				spawn.global_position = Vector2i(-(room_width/2-32),0)
				spawn.set_name("PlayerSpawnLeft")
		self.room.add_child(spawn)
		

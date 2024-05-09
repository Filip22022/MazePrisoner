extends Node2D

var room_height = 256
var room_width = 416
var room

func build(directions):
	room = load("res://maze_generation/room_builder/empty_room.tscn").instantiate()
	
	_build_walls(directions)
	_add_player_spawns(directions)
	
	return room
	
	
func _build_walls(open_directions):
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
	
func _add_player_spawns(open_directions):
	for dir in open_directions:
		var spawn = Marker2D.new()
		match dir:
			Directions.Direction.Up:
				spawn.global_position = Vector2i(0, -(room_height/2-32))
				spawn.set_name("PlayerSpawnTop")
			Directions.Direction.Right:
				spawn.global_position = Vector2i((room_width/2-32),0)
				spawn.set_name("PlayerSpawnRight")
			Directions.Direction.Down:
				spawn.global_position = Vector2i(0, room_height/2-32)
				spawn.set_name("PlayerSpawnDown")
			Directions.Direction.Left:
				spawn.global_position = Vector2i(-(room_width/2-32),0)
				spawn.set_name("PlayerSpawnLeft")
		self.room.add_child(spawn)
		self.room.default_spawn = spawn
		
func build_final_room(directions):
	room = build(directions)
	
	
	var script = load("res://maze_generation/room_builder/final_room_scene.gd")
	room.set_script(script)
	
	
	var exit = load("res://scenes/objects/exit/maze_exit.tscn").instantiate()
	exit.global_position = Vector2i(0,0)
	exit.maze_finished.connect(room.maze_finished)
	room.add_child(exit)
	 
	return room

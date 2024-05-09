class_name MazeRoom
extends Node

var x: int
var y: int
var room_scene_path: String
var connected_rooms = {}
var walls_id = 15
#TODO remove walls_id when obsolete
var color = 0
var is_final = false
var room_scene: RoomScene

func connect_room(other_room):
	var side: Directions.Direction = check_neighbor_side(other_room)
	if side not in self.connected_rooms:
		self.remove_wall(side)
		self.connected_rooms[side] = other_room
		other_room.connect_room(self)
	
func disconnect_room(other_room):
	var side: Directions.Direction = check_neighbor_side(other_room)
	if side in self.connected_rooms:
		self.connected_rooms.erase(side)
		self.add_wall(side)
		other_room.disconnect_room(self)

func remove_wall(side: Directions.Direction):
	if self.walls_id > side:
		self.walls_id =  walls_id - pow(2,side)
	
func add_wall(side: Directions.Direction):
	self.walls_id = walls_id + pow(2,side)
		
func set_color(color):
	if self.color == 0:
		self.color = color

func close_room():
	self.walls_id = 0
	
func set_as_final():
	self.is_final = true
	self.room_scene_path = Rooms.get_final_room_path()
	
func check_neighbor_side(r2):
	if (self.x - r2.x == -1 && self.y == r2.y):
		return Directions.Direction.Right
	if (self.x - r2.x == 1 && self.y == r2.y):
		return Directions.Direction.Left
	if (self.x == r2.x && self.y - r2.y == 1):
		return Directions.Direction.Up
	if (self.x == r2.x && self.y - r2.y == -1):
		return Directions.Direction.Down
#
#func get_scene_path():
	#if not self.room_scene_path:
		#self.room_scene_path = Rooms.get_room_path(self.walls_id)
	#return self.room_scene_path 
	#TODO remove with rooms autoload and room scenes when obsolete
	
func get_room_scene():
	if not self.room_scene:
		self.room_scene = RoomBuilder.build(connected_rooms.keys())
	return self.room_scene

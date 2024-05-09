class_name MazeRoom
extends Node

var x: int
var y: int
var connected_rooms = {}
var color = 0
var is_final = false
var room_scene: RoomScene

func connect_room(other_room):
	var side: Directions.Direction = check_neighbor_side(other_room)
	if side not in self.connected_rooms:
		self.connected_rooms[side] = other_room
		other_room.connect_room(self)
	
func disconnect_room(other_room):
	var side: Directions.Direction = check_neighbor_side(other_room)
	if side in self.connected_rooms:
		self.connected_rooms.erase(side)
		other_room.disconnect_room(self)
		
func set_color(color):
	if self.color == 0:
		self.color = color
	
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
	
func get_room_scene():
	if not self.room_scene:
		self.room_scene = RoomBuilder.build(connected_rooms.keys())
	return self.room_scene

class_name MazeRoom
extends Node

var x: int
var y: int
var connected_rooms = []
var walls_id = 0
var color = 0

func connect_room(other_room):
	if other_room not in self.connected_rooms:
		var side = check_neighbor_side(other_room)
		self.remove_wall(side)
		self.connected_rooms.append(other_room)
		other_room.connect_room(self)
	
func disconnect_room(other_room):
	if other_room in self.connected_rooms:
		self.connected_rooms.remove(other_room)
		var side = check_neighbor_side(other_room)
		self.add_wall(side)
		other_room.disconnect_room(self)

func remove_wall(side: Room_Directions.Direction):
	self.walls_id = pow(2,side) + walls_id
	
func add_wall(side: Room_Directions.Direction):
	if self.walls_id > side:
		self.walls_id = walls_id - pow(2,side)
		
func set_color(color):
	if self.color == 0:
		self.color = color

func close_room():
	self.walls_id = 0
	
func check_neighbor_side(r2):
	if (self.x - r2.x == -1 && self.y == r2.y):
		return Room_Directions.Direction.Right
	if (self.x - r2.x == 1 && self.y == r2.y):
		return Room_Directions.Direction.Left
	if (self.x == r2.x && self.y - r2.y == 1):
		return Room_Directions.Direction.Up
	if (self.x == r2.x && self.y - r2.y == -1):
		return Room_Directions.Direction.Down


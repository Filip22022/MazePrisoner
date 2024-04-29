extends Node

# Returns a room scene path based on the number and placement of doors
# The bits in door integer correspond to open/closed doors
# bits: top|right|down|left
static func get_room_path(doors: int):
	var room_name = "room" + str(doors)
	var path = "res://scenes/rooms/" + room_name + ".tscn"
	
	return path
	
static func get_final_room_path():
	return "res://scenes/rooms/final room/final_room.tscn"

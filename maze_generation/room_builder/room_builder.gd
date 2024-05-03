class_name RoomBuilder
extends Node2D

var room_height = 320
var room_width = 480
var room

func _init():
	build()

func build():
	room = load("res://maze_generation/room_builder/empty_room.tscn").instantiate()
	add_child(room)
	
	build_walls()
	
	var player = load("res://player/player.tscn").instantiate()
	add_child(player)
	
func build_walls():
	var left_wall = load("res://maze_generation/room_builder/walls/left_wall_open.tscn").instantiate()
	left_wall.global_position = Vector2i(-room_width/2,0)
	room.add_child(left_wall)
	
	var right_wall = load("res://maze_generation/room_builder/walls/right_wall_closed.tscn").instantiate()
	right_wall.global_position = Vector2i(room_width/2,0)
	room.add_child(right_wall)
	
	var top_wall = load("res://maze_generation/room_builder/walls/top_wall_closed.tscn").instantiate()
	top_wall.global_position = Vector2i(0, -room_height/2)
	room.add_child(top_wall)
	
	var bottom_wall = load("res://maze_generation/room_builder/walls/bottom_wall_closed.tscn").instantiate()
	bottom_wall.global_position = Vector2i(0, room_height/2)
	room.add_child(bottom_wall)

extends Node

var run_in_progress: bool
var maze_size: int = 3

func _init():
	run_in_progress = false
	maze_size = 3

func restart():
	_init()

func end_run():
	run_in_progress = false

func start_run():
	run_in_progress = true
	
func enlarge_maze():
	maze_size += 1

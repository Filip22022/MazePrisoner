extends Node

var run_in_progress: bool

func _init():
	run_in_progress = false

func end_run():
	run_in_progress = false

func start_run():
	run_in_progress = true

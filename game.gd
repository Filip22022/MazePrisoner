extends Node2D

@onready var scene_manager = $SceneManager
@onready var ui_manager = $UIManager

func _ready():
	scene_manager.run_ended.connect(end_run)
	scene_manager.run_started.connect(start_run)
	ui_manager.exit_game.connect(exit_game)

func start_game():
	scene_manager.start_game()
	ui_manager.start_game()
	
func start_run():
	scene_manager.start_run_deferred()
	ui_manager.start_run()
	
func end_run():
	scene_manager.end_run()
	ui_manager.end_run()

func end_game():
	scene_manager.end_game.call_deferred()
	ui_manager.end_game.call_deferred()

func exit_game():
	get_tree().quit()

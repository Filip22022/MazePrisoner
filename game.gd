extends Node2D

@onready var scene_manager = $SceneManager
@onready var ui_manager = $UIManager

func _ready():
	scene_manager.run_ended_won.connect(win_run)
	scene_manager.run_ended_lost.connect(loose_run)
	scene_manager.run_started.connect(start_run)
	scene_manager.game_start.connect(start_game)
	ui_manager.exit_game.connect(exit_game)
	ui_manager.game_restarted.connect(restart_game)

func start_game():
	scene_manager.start_game()
	ui_manager.start_game()
	
	
func restart_game():
	GameState.restart()
	PlayerInfo.restart()
	get_tree().reload_current_scene()
	
func start_run():
	scene_manager.start_run_deferred()
	ui_manager.start_run()
	
func loose_run():
	end_run()
	
func end_run():
	scene_manager.end_run()
	ui_manager.end_run()

func end_game():
	scene_manager.end_game.call_deferred()
	ui_manager.end_game.call_deferred()

func exit_game():
	get_tree().quit()
	
func win_run():
	PlayerInfo.earn_coins(GameState.maze_size)
	GameState.enlarge_maze()
	end_run()

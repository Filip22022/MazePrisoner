extends Node2D

@onready var scene_manager = $SceneManager
@onready var ui_manager = $UIManager

func _ready():
	scene_manager.game_over.connect(end_game)
	ui_manager.exit_game.connect(exit_game)

func start_game():
	scene_manager.start_game()
	ui_manager.start_game()

func end_game():
	scene_manager.end_game.call_deferred()
	ui_manager.end_game.call_deferred()

func exit_game():
	get_tree().quit()

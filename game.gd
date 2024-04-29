extends Node2D

@onready var scene_manager = $SceneManager
@onready var ui_manager = $UIManager

func _ready():
	scene_manager.player_death.connect(end_game)
	scene_manager.game_won.connect(end_game)

func start_game():
	scene_manager.start_game()
	ui_manager.start_game()

func end_game():
	scene_manager.game_over.call_deferred()
	ui_manager.game_over.call_deferred()

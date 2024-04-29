extends Scene

signal game_won

func maze_finished():
	game_won.emit()

func get_player_spawn():
	return $PlayerSpawn.global_position

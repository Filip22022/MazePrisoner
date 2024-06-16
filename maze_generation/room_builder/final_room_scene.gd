extends RoomScene


signal game_won

func maze_finished():
	if GameState.run_in_progress:
		game_won.emit()
	GameState.end_run()

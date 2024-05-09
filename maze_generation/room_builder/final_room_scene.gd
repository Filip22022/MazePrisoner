extends RoomScene


signal game_won

func maze_finished():
	game_won.emit()

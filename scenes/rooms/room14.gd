extends Scene

func get_player_spawn():
	match self.entered_from:
		Room_Directions.Direction.Up:
			return $PlayerSpawnTop.global_position

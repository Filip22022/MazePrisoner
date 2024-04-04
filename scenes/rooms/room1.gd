extends Scene

func get_player_spawn():
	match self.entered_from:
		Room_Directions.Direction.Right:
			return $PlayerSpawnRight.global_position
		Room_Directions.Direction.Down:
			return $PlayerSpawnDown.global_position
		Room_Directions.Direction.Left:
			return $PlayerSpawnLeft.global_position

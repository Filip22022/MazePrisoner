extends Node

enum Direction {
	Up = 0,
	Right = 1,
	Down = 2,
	Left = 3,
}

func opposite(dir: Direction):
	match dir:
		Direction.Up:
			return Direction.Down
		Direction.Right:
			return Direction.Left
		Direction.Down:
			return Direction.Up
		Direction.Left:
			return Direction.Right

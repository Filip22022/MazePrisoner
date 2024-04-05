extends Scene

func open_doors(directions):
	for direction in directions.keys():
		var door = get_door(direction)
		door.open()
		
func close_doors(directions):
	for direction in directions.keys():
		var door = get_door(direction)
		door.close()
		
func get_door(direction: Directions.Direction):
	match direction:
		Directions.Direction.Up:
			if self.has_node("DoorUp"):
				return self.get_node("DoorUp")
		Directions.Direction.Right:
			if self.has_node("DoorRight"):
				return self.get_node("DoorRight")
		Directions.Direction.Down:
			if self.has_node("DoorDown"):
				return self.get_node("DoorDown")
		Directions.Direction.Left:
			if self.has_node("DoorLeft"):
				return self.get_node("DoorLeft")

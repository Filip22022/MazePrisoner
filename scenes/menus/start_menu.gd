extends Scene

func _on_start_button_pressed():
	scene_change_requested.emit("res://scenes/rooms/room15.tscn", Room_Directions.Direction.Down)

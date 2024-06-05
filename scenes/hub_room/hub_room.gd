class_name HubRoom
extends RoomScene

signal run_started

func _on_area_entered(_area):
	if not GameState.run_in_progress:
		run_started.emit()

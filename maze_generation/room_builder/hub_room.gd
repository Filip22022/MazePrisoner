class_name HubRoom
extends RoomScene

signal run_started
var started: bool = false

func _on_area_entered(_area):
	if not started:
		started = true
		run_started.emit()

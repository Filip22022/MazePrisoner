extends Control

signal timeout

func _process(delta):
	$TimerLabel.text = time_to_string($Timer.time_left)

func start(time_minutes: float):
	$Timer.start(time_minutes*60)
	
func stop():
	$Timer.stop()

func time_to_string(time_in_seconds):
	var seconds = int(time_in_seconds)%60
	var minutes = (int(time_in_seconds) - seconds)/60
	if seconds < 10:
		return str(minutes) + ":" + "0" + str(seconds)
	return str(minutes) + ":" + str(seconds)
	
func emit_timeout():
	timeout.emit()

class_name UIManager
extends CanvasLayer

var timer
	
func start_game():
	timer = load("res://UI/timer_hud.tscn").instantiate()
	add_child(timer)
	timer.start(3)


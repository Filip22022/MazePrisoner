class_name UIManager
extends CanvasLayer

signal exit_game

var isPaused: bool = false:
	get:
		return isPaused
	set(value):
		isPaused = value
		get_tree().paused = isPaused
@onready var timer = $GameTimer
@onready var pause_menu

func _ready():
	timer.hide()
	pause_menu = load("res://UI/pause_menu/pause_menu.tscn").instantiate()
	add_child(pause_menu)
	
	pause_menu.resume.connect(toggle_pause_menu)
	pause_menu.exit_game.connect(on_game_exit)
	
func _input(event):
	if(event.is_action_pressed("pause")):
		toggle_pause_menu()
		
func toggle_pause_menu():
	isPaused = !isPaused
	if isPaused:
		pause_menu.show()
	else:
		pause_menu.hide()
	
func start_game():
	timer.show()
	timer.start(3)

func end_game():
	timer.stop()
	timer.hide()
	
func on_game_exit():
	exit_game.emit()
	

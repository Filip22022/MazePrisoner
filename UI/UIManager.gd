class_name UIManager
extends CanvasLayer

signal exit_game
signal game_restarted


var isPaused: bool = false:
	get:
		return isPaused
	set(value):
		isPaused = value
		get_tree().paused = isPaused
@onready var timer = $GameTimer
@onready var pause_menu
@onready var stats_hud

func _ready():
	timer.hide()
	pause_menu = load("res://UI/pause_menu/pause_menu.tscn").instantiate()
	add_child(pause_menu)
	stats_hud = load("res://UI/HUD/hud_stats.tscn").instantiate()
	add_child(stats_hud)
	
	pause_menu.resume.connect(toggle_pause_menu)
	pause_menu.exit_game.connect(on_game_exit)
	pause_menu.restart_game.connect(restart_game)
	
func _input(event):
	if(event.is_action_pressed("pause")):
		toggle_pause_menu()
		
func toggle_pause_menu():
	isPaused = !isPaused
	if isPaused:
		pause_menu.show()
		stats_hud.show_menu()
	else:
		pause_menu.hide()
		stats_hud.hide_menu()
	
func start_game():
	pass
	
func start_run():
	timer.show()
	timer.start(3)

func end_game():
	pass
		
func restart_game():
	if isPaused:
		toggle_pause_menu()	
	game_restarted.emit()
	
func end_run():
	timer.stop()
	timer.hide()
	
func on_game_exit():
	exit_game.emit()
	

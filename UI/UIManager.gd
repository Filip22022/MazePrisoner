class_name UIManager
extends CanvasLayer

@onready var timer = $GameTimer

func _ready():
	timer.hide()
	
func start_game():
	pass
	
func start_run():
	timer.show()
	timer.start(3)

func end_game():
	pass
	
func end_run():
	timer.stop()
	timer.hide()

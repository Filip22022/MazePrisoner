class_name UIManager
extends CanvasLayer

@onready var timer = $GameTimer

func _ready():
	timer.hide()
	
func start_game():
	timer.show()
	timer.start(3)

extends Scene

signal start_game

func _ready():
	self.start_game.connect(get_parent().start_game)

func _on_start_button_pressed():
	start_game.emit()

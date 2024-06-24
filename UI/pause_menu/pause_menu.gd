extends Control

signal resume
signal exit_game
signal restart_game

func _ready():
	self.hide()

func _on_resume_pressed():
	resume.emit()


func _on_quit_pressed():
	exit_game.emit()


func _on_restart_pressed():
	restart_game.emit()

extends Area2D

signal maze_finished()

	
func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(_area):
	emit_signal("maze_finished")

class_name RoomTransitionArea
extends Area2D

signal transition_entered

func _init():
	set_collision_layer(8)
	set_collision_mask(8)
	
func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(_area):
	emit_signal("transition_entered")

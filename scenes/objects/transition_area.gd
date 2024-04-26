class_name TransitionArea
extends Area2D

@export var scene_path: String
signal transition_entered(scene_path: String)

func _init():
	set_collision_layer(4)
	set_collision_mask(4)
	
func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(_area):
	emit_signal("transition_entered", scene_path)

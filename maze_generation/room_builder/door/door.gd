class_name Door
extends Node2D

@onready var _animation_player = $StaticBody2D/AnimationPlayer
@onready var _transition_area = $RoomTransitionArea
@onready var _door_dollision_shape = $StaticBody2D/DoorShape

@export var direction: Directions.Direction

signal entered(dir: Directions.Direction)

func _ready():
	add_to_group("doors")
	_transition_area.transition_entered.connect(door_entered)

func open():
	_animation_player.play("door_opening")
	_door_dollision_shape.disabled = true
	
func close():
	_animation_player.play("door_closing")
	_door_dollision_shape.disabled = false

func door_entered():
	entered.emit(self.direction)

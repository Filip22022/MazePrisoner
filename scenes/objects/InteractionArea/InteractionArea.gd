extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"
@onready var label: Label = $Label

var interact: Callable = func():
	pass


func _ready():
	label.text = "[E] to " + action_name
	label.hide()
	
	self.add_to_group("InteractionAreas")
	
func _on_area_entered(body):
	InteractionManager.register_area(self)

func _on_area_exited(body):
	InteractionManager.unregister_area(self)
	
func show_label():
	label.show()

func hide_label():
	label.hide()

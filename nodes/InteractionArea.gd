extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"
@onready var label: Label

var interact: Callable = func():
	pass


func _init():
	var label = Label.new()
	label.global_position = self.global_position
	label.global_position.y -= 36
	label.global_position.x -= label.size.x / 2
	label.text = "[E] to " + action_name
	add_child(label)
	
	self.add_to_group("InteractionAreas")
		
func _on_body_entered(body):
	InteractionManager.register_area(self)

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
	
func show_label():
	label.show()

func hide_label():
	label.hide()

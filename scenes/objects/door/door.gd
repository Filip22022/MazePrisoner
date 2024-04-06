class_name Door
extends Node2D

func open():
	%Sprite.visible = false
	%CollisionShape2D.disabled = true
	
func close():
	%Sprite.visible = true
	%CollisionShape2D.disabled = false
	

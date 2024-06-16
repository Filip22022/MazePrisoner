extends CanvasLayer

@onready var health_label = $Panel/VBoxContainer/HBoxContainer/HealthValue
@onready var speed_label = $Panel/VBoxContainer/HBoxContainer2/SpeedValue
@onready var damage_label = $Panel/VBoxContainer/HBoxContainer3/DamageValue
@onready var maze_size_label = $Panel2/VBoxContainer2/HBoxContainer2/SizeValue
@onready var coins_label = $Panel2/VBoxContainer2/HBoxContainer/CoinsValue

func _ready():
	hide()

func show_menu():
	self.update()
	self.show()

func hide_menu():
	self.hide()
	
func update():
	health_label.text = str(PlayerInfo.get_stat(PlayerInfo.StatNames.health))
	speed_label.text = str(PlayerInfo.get_stat(PlayerInfo.StatNames.speed))
	damage_label.text = str(PlayerInfo.get_stat(PlayerInfo.StatNames.damage))
	coins_label.text = str(PlayerInfo.get_stat(PlayerInfo.StatNames.coins))
	maze_size_label.text = str(GameState.maze_size*GameState.maze_size)

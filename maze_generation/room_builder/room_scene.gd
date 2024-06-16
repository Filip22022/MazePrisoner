class_name RoomScene
extends Scene

var default_spawn: Marker2D

func _ready():
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		door.entered.connect(_on_transition_area_transition_entered)
		
		

func room_cleared():
	open_doors()

func open_doors():
	get_tree().call_group("doors", "open")
	
func close_doors():
	get_tree().call_group("doors", "close")

func get_player_spawn():
	var player_spawn = super.get_player_spawn()
	if not player_spawn:
		player_spawn =  self.default_spawn.global_position
	return player_spawn

class_name MazeGenerator
extends TileMap

@export var size: int = 3
var rooms = []
var ready_path = []
var rng: RandomNumberGenerator
var starting_cell: MazeRoom
#var color_counter = 2
#var tick = 0

func _init():
	rng = RandomNumberGenerator.new()

func _initialize():
	rng.randomize()
	ready_path = []
	rooms = []
	
	for i in range(0, size):
		rooms.append([])
		for j in range(0, size):
			var room = MazeRoom.new()
			room.x = i
			room. y = j
			rooms[i].append(room)
			#_visualize(room,0)
	
	# Choose center cell as starting cell
	self.starting_cell = rooms[(size-1)/2][(size-1)/2]
	ready_path.append(starting_cell)
	#_visualize_ends(starting_cell)

	
func _maze_incomplete():
	for i in range(size):
		for j in range(size):
			if rooms[i][j] not in ready_path:
				return true
	return false
	
#func _process(delta):
	#if maze_incomplete():
		#if tick == 20:
			#tick = 0
			#generate_new_path()
			#
		#else: 
			#tick += 1
			#
	#_show_rooms()
	
func generate_maze():
	_initialize()
	while _maze_incomplete():
		_generate_new_path()
	var escape_cell = _random_escape_cell()
	escape_cell.set_as_final()
	return ready_path
	
func get_starting_room():
	return self.starting_cell
	
func _random_escape_cell():
	# Choose random edge cell as escape_cell
	var bounds = [0,size-1]
	var escape_coordinates = [rng.randi_range(0, size-1),bounds[rng.randi_range(0,1)]]
	var x = rng.randi_range(0,1)
	var escape_cell = rooms[escape_coordinates[x]][escape_coordinates[1-x]]
	#_visualize_ends(escape_cell)
	return escape_cell
	
func _generate_new_path():
	var current_cell = _random_new_cell()
	var current_path = []
	current_path.append(current_cell)
	while true:
		var new_cell = _open_wall(current_cell)
		if new_cell in ready_path:
			current_path.append(new_cell)
			#_color_path(current_path)
			_merge_path(current_path)
			return
		if new_cell in current_path:
			_erase_loop(current_path, new_cell)
			
		current_cell = new_cell
		current_path.append(current_cell)

func _open_wall(cell):
	var new_cell: MazeRoom = null
	while new_cell == null:
		match rng.randi_range(0,3):
			0:
				#Top
				if cell.y != 0:
					new_cell = rooms[cell.x][cell.y-1]
			1:
				#Right
				if cell.x != size-1:
					new_cell = rooms[cell.x+1][cell.y]
			2:
				#Down
				if cell.y != size-1:
					new_cell = rooms[cell.x][cell.y+1]
			3:
				#Left
				if cell.x != 0:
					new_cell = rooms[cell.x-1][cell.y]
	return new_cell
	
func _erase_loop(current_path, repeated_room):
	var start = current_path.find(repeated_room)
	for i in range(len(current_path), start, -1):
		current_path.pop_back()
		#var popped_cell = current_path.pop_back()
		#popped_cell.close_room()
		#popped_cell.set_color(0)
	
func _merge_path(new_path):
	for i in range(len(new_path)-1):
		var room = new_path[i]
		room.connect_room(new_path[i+1])
		ready_path.append(room)
		
func _random_new_cell():
	var x = rng.randi_range(0,size-1) 
	var y = rng.randi_range(0,size-1) 
	
	while rooms[x][y] in ready_path:	
		x = rng.randi_range(0,size-1) 
		y = rng.randi_range(0,size-1) 
		
	var new_cell = rooms[x][y]
	return new_cell
	
#func _color_path(path): 
	##for cell in path:
		##cell.set_color(color_counter)
		#
	#color_counter += 1
	#if color_counter > 11:
		#color_counter = 2
	
func _show_rooms():
	for row in rooms:
		for room in row:
			_visualize(room, room.color)
			_visualize_walls(room)
			
func _remove_colors():
	for row in rooms:
		for room in row:
			_visualize(room, 0)
	
func _visualize(cell, color):
	set_cell(0, Vector2i(cell.x+5,cell.y+5), 1, Vector2i(0,color))
	
func _visualize_walls(room):
	set_cell(1, Vector2i(room.x+5,room.y+5), 0, Vector2i(0, room.walls_id))
	
func _visualize_ends(cell):
	set_cell(2, Vector2i(cell.x+5,cell.y+5), 2, Vector2i(12,9))

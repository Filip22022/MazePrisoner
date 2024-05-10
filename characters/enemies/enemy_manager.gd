extends Node2D

var Enemy = [preload("res://characters/enemies/enemy1/enemy1.tscn"), preload("res://characters/enemies/enemy2/enemy2.tscn"), preload("res://characters/enemies/enemy3/enemy2.tscn")]

func spawn_enemies(number: int):
	
	var spawns = get_tree().get_nodes_in_group("enemy_spawns")
	if spawns.size() == 0:
		return
	
	for n in range(number):
		var id_enemy = randi_range(0,2)
		var spawn = spawns[randi()%spawns.size()]
		spawns.erase(spawn)
		var enemy = Enemy[id_enemy].instantiate()
		enemy.position = spawn.position
		enemy.add_to_group("enemies")
		add_child(enemy)

func clear_enemies():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()

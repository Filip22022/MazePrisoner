extends Node2D

var Enemy = preload("res://characters/enemies/enemy1/enemy1.tscn")

func spawn_enemies(number: int):
	
	var spawns = get_tree().get_nodes_in_group("enemy_spawns")
	if spawns.size() == 0:
		return
	
	for n in range(number):
		var spawn = spawns[randi()%spawns.size()]
		spawns.erase(spawn)
		var enemy = Enemy.instantiate()
		enemy.position = spawn.position
		enemy.add_to_group("enemies")
		add_child(enemy)
		print(spawn)
		print(spawns.size())

func clear_enemies():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()

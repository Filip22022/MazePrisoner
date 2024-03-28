extends CharacterBody2D

var health = 40
@onready
var player = get_node("/root/Game/Player")


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	
	move_and_slide()
	
	
func _ready():
	play_walk()
	
func take_damage(damage):
	health -= damage
	play_hurt()
	
	if health <= 0:
		queue_free()
		const SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = self.global_position
		
func play_walk():
	$AnimationPlayer.play("walk")


func play_hurt():
	$AnimationPlayer.play("hurt")
	$AnimationPlayer.queue("walk")

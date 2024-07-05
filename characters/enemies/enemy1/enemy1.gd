extends Enemy

var speed = 100
@onready var animated_sprite = $AnimatedSprite2D

func _init():
	self.health = 5*GameState.maze_size

func _process(delta):
	var player = PlayerInfo.get_player()
	if player:
		self.velocity = (player.get_global_position() - self.position).normalized() * speed
		if player.position.x >= self.position.x:
			animated_sprite.play("walk")
		else: animated_sprite.play("walkLeft")
		move_and_slide()

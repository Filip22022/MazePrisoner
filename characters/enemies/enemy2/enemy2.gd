extends Enemy
signal timeout

var speed = 300
var cooldown1 = 2.0
var timer = 0.0
var cel
var ile: int = 0
@onready var animated_sprite = $AnimatedSprite2D

func _init():
	self.health = PlayerInfo.get_stat(PlayerInfo.StatNames.damage)*3

func _process(delta):
	timer += delta
	var player = PlayerInfo.get_player()
	if player:
		animated_sprite.play("Idle")
		if timer >= cooldown1:
			self.velocity = (player.get_global_position() - self.position).normalized() * speed
			if player.position.x >= self.position.x:
				animated_sprite.play("Run")
			else:
				animated_sprite.play("RunLeft")
			move_and_slide()
			ile += 1
			if self.position == cel or ile == 40:
				timer = 0 
				ile = 0
		else:
			cel = player.get_global_position()

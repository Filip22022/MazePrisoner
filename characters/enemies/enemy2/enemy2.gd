extends Enemy
signal timeout

var speed = 300
var cooldown1 = 2.0
var timer = 0.0
var cel
var ile: int = 0

func _init():
	self.health = 50.0

func _process(delta):
	timer += delta
	var player = PlayerInfo.get_player()
	if player:
		if timer >= cooldown1:
			self.velocity = (player.get_global_position() - self.position).normalized() * speed
			move_and_slide()
			ile += 1
			if self.position == cel or ile == 40:
				timer = 0 
				ile = 0
		else:
			cel = player.get_global_position()

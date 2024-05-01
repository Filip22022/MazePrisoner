extends Enemy

var speed = 100

func _init():
	self.health = 100.0

func _process(delta):
	var player = PlayerInfo.get_player()
	if player:
		self.velocity = (player.get_global_position() - self.position).normalized() * speed
		move_and_slide()

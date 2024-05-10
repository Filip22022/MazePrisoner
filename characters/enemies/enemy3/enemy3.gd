extends Enemy
signal timeout

var speed = 2
var timer = 0.0
var kierunek
var ile: int = 0

func _init():
	self.health = 50.0

func _process(delta):
	var player = PlayerInfo.get_player()
	if player:
		if ile != 0:
			if kierunek == 0:
				self.position += Vector2(speed,0)
			if kierunek == 1:
				self.position += Vector2(0, speed)
			if kierunek == 2:
				self.position -= Vector2(speed,0)
			if kierunek == 3:
				self.position -= Vector2(0, speed)
			move_and_slide()
			ile -= 1
			
		else:
			ile = randi_range(1,15)
			kierunek = randi_range(0,3)

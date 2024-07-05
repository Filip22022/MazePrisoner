extends Enemy
signal timeout

var speed = 2
var timer = 0.0
var kierunek
var ile: int = 0
@onready var animated_sprite = $AnimatedSprite2D

func _init():
	self.health = (GameState.maze_size - 2) * (GameState.maze_size-1)

func _process(delta):
	var player = PlayerInfo.get_player()
	if player:
		if ile != 0:
			if kierunek == 0:
				self.position += Vector2(speed,0)
				animated_sprite.play("Walk")
			if kierunek == 1:
				self.position += Vector2(0, speed)
				animated_sprite.play("Idle")
			if kierunek == 2:
				self.position -= Vector2(speed,0)
				animated_sprite.play("WalkLeft")
			if kierunek == 3:
				self.position -= Vector2(0, speed)
				animated_sprite.play("Idle")
			move_and_slide()
			ile -= 1
			
		else:
			ile = randi_range(1,15)
			kierunek = randi_range(0,3)

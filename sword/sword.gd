extends Area2D

enum STATES {IDLE, ATTACK}
var current_state = STATES.IDLE

func _ready():
	var collider = $"./weaponPivot/Sprite2D/Hitbox/SwordCollider"
	collider.set_disabled(true)


func _physics_process(_delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Attack"):
		_change_state(STATES.ATTACK)
	
func _change_state(new_state):
	current_state = new_state
	
	match current_state:
		STATES.IDLE:
			$AnimationPlayer.play("idle")
		STATES.ATTACK:
			$AnimationPlayer.play("swing")
		


func _on_animation_player_animation_finished(_anim_name):
	_change_state(STATES.IDLE)

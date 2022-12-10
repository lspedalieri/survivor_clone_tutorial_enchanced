extends CharacterBody2D

var movement_speed = 40.0
var hp = 80
@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")

func _physics_process(delta):
	movement()
	
func  movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_raw_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_raw_strength("up")
	if x_mov > 0:
		sprite.flip_h = true
	elif x_mov < 0:
		sprite.flip_h = false
	var mov = Vector2(x_mov, y_mov)
	if mov != Vector2.ZERO:
		if walkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walkTimer.start()
	velocity = mov.normalized() * movement_speed
	#velocity = Input.get_vector("left","right","up","down").normalized() * movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)

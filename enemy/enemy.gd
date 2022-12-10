extends CharacterBody2D

@export var movement_speed = int(20)
@export var hp = 10

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

func _ready():
	anim.play("walk")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false
	velocity = direction * movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		queue_free()

extends Area2D

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableHitBoxTimer

#Disable hitbox collision when called and start timer
func tempDisable():
	collision.call_deferred("set", "disabled", true)
	disableTimer.start()
	
#Enable hitbox collision at the end of timer
func _on_disable_hit_box_timer_timeout():
	collision.call_deferred("set", "disabled", false)

extends Area2D

@export_enum('Cooldown', 'HitOnce', 'DisableHitBox') var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)

#when hurtbox collides with hitboxes
func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #Cooldown HurtBox: disable own body hurtbox
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1: #HitOnce HurtBox
					pass
				2: #DisableHitBox HurtBox of the area hit
					if area.has_method("tempDisable"):
						area.tempDisable()
			var damage = area.damage
			emit_signal("hurt", damage)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)



#re-enable collision shape
func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)

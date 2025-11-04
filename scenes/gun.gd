extends Area2D

const BULLET = preload("res://scenes/bullet_2d.tscn")

var fire_rate = 1.0
var time_since_last_shot = 1.0
	
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	time_since_last_shot += delta

	if Input.is_action_pressed("shoot") and time_since_last_shot >= fire_rate:
		shoot()
		time_since_last_shot = 0.0


func shoot() -> void:
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %ShootingPoint.global_transform
	%ShootingPoint.add_child(new_bullet)
	

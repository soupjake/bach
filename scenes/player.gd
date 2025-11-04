extends CharacterBody2D

signal health_depleted

var health := 100.0
var move_speed := 600.0
var dash_speed := 1200.0
var dash_duration := 0.2
var dash_cooldown := 1.0

var dash_timer := 0.0
var cooldown_timer := 0.0
var is_dashing := false
var dash_direction := Vector2.ZERO

const DAMAGE_RATE := 6.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	
	if Input.is_action_just_pressed("dash") and cooldown_timer <= 0.0:
		start_dash(direction)
		
	if is_dashing:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			cooldown_timer = dash_cooldown
	else:
		velocity = direction * move_speed
		cooldown_timer = max(cooldown_timer - delta, 0.0)
		
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func start_dash(input_dir: Vector2) -> void:
	is_dashing = true
	dash_timer = dash_duration
	dash_direction = input_dir if input_dir != Vector2.ZERO else Vector2.DOWN

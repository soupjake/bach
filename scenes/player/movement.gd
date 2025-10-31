class_name Movement

var sprinting := false

func process(body: CharacterBody3D, stats: Stats, delta: float) -> void:
	var speed = stats.base_speed

	# Add the gravity.
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and body.is_on_floor():
		body.velocity.y = stats.jump_velocity
		
	if Input.is_action_pressed("sprint"):
		sprinting = true
		speed = stats.base_speed * 2
		
	if Input.is_action_just_released("sprint"):
		sprinting = false
		speed = stats.base_speed
		
	if Input.is_action_pressed("aim"):
		sprinting = false
		speed = stats.base_speed / 2
		
	if Input.is_action_just_released("aim"):
		speed = stats.base_speed

	# Movement direction
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		body.velocity.x = direction.x * speed
		body.velocity.z = direction.z * speed
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, speed)
		body.velocity.z = move_toward(body.velocity.z, 0, speed)

	body.move_and_slide()

class_name Shoot

var shooting := false
var charge := 0.0

func process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		shooting = true
		
	if Input.is_action_just_released("shoot"):
		shooting = false
	
	if Input.is_action_pressed("sprint"):
		shooting = false
		
	if Input.is_action_pressed("aim"):
		if charge < 1.0:
			charge += 1.0 * delta
	else:
		if charge > 0 and charge < 1.0:
			charge -= 1.0 * delta
		
	if shooting:
		if charge >= 1.0:
			print("charged shooting")
			charge = 0
		else:
			print("shooting")

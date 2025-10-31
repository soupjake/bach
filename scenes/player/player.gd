extends CharacterBody3D

var stats := Stats.new()
var movement := Movement.new()
var shoot := Shoot.new()

func _physics_process(delta: float) -> void:
	movement.process(self, stats, delta)
	shoot.process(delta)

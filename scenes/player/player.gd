extends CharacterBody3D

var stats: PlayerStats
var movement := Movement.new()

func _physics_process(delta: float) -> void:
	movement.handle(self, stats, delta)

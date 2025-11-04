extends CharacterBody2D

var speed := randf_range(200, 300)
var health := 3
const SMOKE = preload("res://assets/smoke_explosion/smoke_explosion.tscn")

@onready var player = get_tree().get_nodes_in_group("player")[0]


func _ready() -> void:
	%Slime.play_walk()


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()


func take_damage() -> void:
	%Slime.play_hurt()
	health -= 1

	if health == 0:
		var smoke = SMOKE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()

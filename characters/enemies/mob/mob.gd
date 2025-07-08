extends CharacterBody2D

@export var speed := 300.0
@onready var player = get_node("/root/Map/Player")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

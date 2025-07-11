extends CharacterBody2D

@export var speed := 300.0
@onready var player = get_node("/root/Map/Player")
@onready var coin_drop: CoinDropManager = %CoinDropManager

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

var health := 100

func take_damage():
	health -= 50
	if health <= 0:
		coin_drop.drop_coin(global_position)
		queue_free()
		

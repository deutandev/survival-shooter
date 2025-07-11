extends CharacterBody2D
class_name Player

@export var speed: float = 600.0
@onready var health: HealthManager = %HealthManager
@onready var hurt_manager: HurtManager = %HurtManager
@onready var coin_collector = %CoinCollectorArea

func _ready() -> void:
	health.reset()
	health.dead.connect(on_player_death)
	hurt_manager.target = self

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	check_for_coins()

func check_for_coins():
	for area in coin_collector.get_overlapping_areas():
		if area.is_in_group("coin"):
			if area.has_method("collect"):
				area.collect()

func on_player_death():
	#await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://environment/mainMenu.tscn")

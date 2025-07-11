extends CharacterBody2D
class_name Player

@export var speed: float = 600.0
@onready var health: Health_manager = %HealthManager
@onready var hurt_manager: Hurt_manager = %HurtManager

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

func on_player_death():
	#await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://environment/mainMenu.tscn")

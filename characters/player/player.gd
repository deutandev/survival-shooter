extends CharacterBody2D
class_name Player

@export var speed: float = 600.0
@onready var health: HealthManager = %HealthManager
@onready var hurt_manager: HurtManager = %HurtManager

@onready var bomb: Area2D = %Bomb
@export var bomb_cooldown: float = 3.0
var can_use_bomb := true

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
	if Input.is_action_just_pressed("interact") and can_use_bomb:
		use_bomb()

func use_bomb():
	if !can_use_bomb or !bomb:
		return
	
	can_use_bomb = false

	# Reuse bomb — reposition + reactivate
	bomb.reset(global_position)

	await get_tree().create_timer(bomb_cooldown).timeout
	can_use_bomb = true

func on_player_death():
	#await get_tree().create_timer(1.0).timeout
	call_deferred("go_to_menu")

func go_to_menu():
	get_tree().change_scene_to_file("res://environment/mainMenu.tscn")

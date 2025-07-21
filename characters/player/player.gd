extends CharacterBody2D
class_name Player

signal player_died
signal bomb_cooldown_started(duration: float)
signal bomb_cooldown_ended()

@export var player_data : CharacterData

@export var speed: float = 600.0
@onready var health: HealthManager = %HealthManager
@onready var hurt_manager: HurtManager = %HurtManager
@onready var gun: Area2D = %Gun

@onready var bomb: Area2D = %Bomb
@export var bomb_cooldown: float = 3.0

var can_use_bomb := true

func _ready() -> void:
	health.reset()
	health.dead.connect(on_player_death)
	hurt_manager.target = self
	# Connect signal from Gun
	if gun:
		gun.shoot_direction_changed.connect(_on_shoot_direction_changed)


func _on_shoot_direction_changed(facing_right: bool):
	# Flip the sprite to match shooting direction
	$Sprite2D.flip_h = not facing_right


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	if Input.is_action_just_pressed("interact"):
		use_bomb()

func use_bomb():
	if !can_use_bomb or !bomb:
		return
	can_use_bomb = false
	bomb.reset(global_position)
	emit_signal("bomb_cooldown_started", bomb_cooldown)
	await get_tree().create_timer(bomb_cooldown).timeout
	can_use_bomb = true
	emit_signal("bomb_cooldown_ended")

func on_player_death():
	player_died.emit()
	#await get_tree().create_timer(1.0).timeout
	#call_deferred("go_to_menu")

#func go_to_menu():
	#get_tree().change_scene_to_file("res://environment/main_menu/mainMenu.tscn")

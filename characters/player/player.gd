extends CharacterBody2D
class_name Player

signal player_died
signal skill_cooldown_started(duration: float)
signal skill_cooldown_ended()

@export var player_data : CharacterData
@onready var player_animation := $PlayerAnimatedSprite


@export var speed: float = 600.0
@onready var health: HealthManager = %HealthManager
@onready var hurt_manager: HurtManager = %HurtManager
@onready var gun: Area2D = %Gun

@onready var skill_scene: PackedScene = player_data.skill_scene
@export var skill_cooldown: float = 3.0


var skill: Node = null
var can_use_skill := true

func _ready() -> void:
	health.reset()
	health.dead.connect(on_player_death)
	hurt_manager.target = self
	# Connect signal from Gun
	if gun:
		gun.shoot_direction_changed.connect(_on_shoot_direction_changed)
	
	if skill_scene:
		skill = skill_scene.instantiate()
		skill.global_position = global_position
		skill.owner = self  # optional, in case skill needs to know
		add_child(skill)


func _on_shoot_direction_changed(facing_right: bool):
	# Flip the sprite to match shooting direction
	player_animation.flip_h = not facing_right


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if input_direction != Vector2.ZERO:
		player_animation.play("run")
	else:
		player_animation.play("idle")
	

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	if Input.is_action_just_pressed("interact"):
		use_skill()

func use_skill():
	if !can_use_skill or !skill_scene:
		return
	can_use_skill = false
	skill.reset(global_position)
	emit_signal("skill_cooldown_started", skill_cooldown)
	await get_tree().create_timer(skill_cooldown).timeout
	can_use_skill = true
	emit_signal("skill_cooldown_ended")

func on_player_death():
	player_died.emit()
	#await get_tree().create_timer(1.0).timeout
	#call_deferred("go_to_menu")

#func go_to_menu():
	#get_tree().change_scene_to_file("res://environment/main_menu/mainMenu.tscn")

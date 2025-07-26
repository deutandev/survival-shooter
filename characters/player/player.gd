extends CharacterBody2D
class_name Player

signal player_died
signal skill_cooldown_started(duration: float)
signal skill_cooldown_ended()

@export var player_base_data : CharacterData
@export var skill_cooldown: float = 3.0

@onready var health_manager: HealthManager = %HealthManager
@onready var hurt_manager: HurtManager = %HurtManager
@onready var gun: Area2D = %Gun

@onready var skill_scene: PackedScene = player_base_data.skill_scene
@onready var upgrade_mgr: UpgradeManager = $UpgradeManager


var player_data: PlayerData

var xp: int = 0
var level: int = 1
var xp_to_next: int = 100
var xp_growth_rate: float = 1.25

var skill: Node = null
var can_use_skill := true

var current_atk: int
var current_def: int
var current_speed: float
var current_fire_rate: float


func _ready() -> void:
	player_data = player_base_data.duplicate(true)
	setup_character(player_data)
	health_manager.dead.connect(on_player_death)
	hurt_manager.target = self
	# Connect signal from Gun
	if gun:
		gun.shoot_direction_changed.connect(_on_shoot_direction_changed)
	
	if skill_scene:
		skill = skill_scene.instantiate()
		skill.global_position = global_position
		add_child(skill)
	print(current_speed)


func _on_shoot_direction_changed(facing_right: bool):
	# Flip the sprite to match shooting direction
	$Sprite2D.flip_h = not facing_right


func setup_character(data: CharacterData):
	health_manager.max_health = data.max_health
	health_manager.current_health = data.max_health
	hurt_manager.defense = data.defense
	current_speed = data.speed


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * current_speed

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


func get_stat(stat_name: String):
	match stat_name:
		"max_health":
			return health_manager.max_health
		"speed":
			return current_speed
		"defense":
			return hurt_manager.defense
		"fire_rate":
			return current_fire_rate
		_:
			print("⚠️ Unknown stat:", stat_name)
			return null

func set_stat(stat_name: String, value):
	match stat_name:
		"max_health":
			health_manager.max_health = value
			health_manager.current_health = min(health_manager.current_health, value)
			health_manager.health_changed.emit(health_manager.current_health, health_manager.max_health)
			print("✅ Health upgraded to:", value)
		"speed":
			current_speed = value
			print("✅ Speed upgraded to:", value)
		"defense":
			hurt_manager.defense = value
			print("✅ Defense upgraded to:", value)
		"fire_rate":
			current_fire_rate = value
			if gun:
				gun.fire_rate = value
				print("✅ Fire rate upgraded to:", value)
		_:
			print("⚠️ Cannot set unknown stat:", stat_name)

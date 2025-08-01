extends CharacterBody2D
class_name Mob

# Resource that defines this enemy's properties
@export var stats: EnemyData

# Node references
@onready var player: CharacterBody2D
@onready var coin_drop: CoinDropManager = %CoinDropManager
@onready var health_label: Label = $HealthLabel
@onready var sprite: Sprite2D = $MobSprite

#Skill Orb Drop
@onready var skill_orb_drop: SkillOrbDropManager = %SkillOrbDropManager


# Runtime variables
var current_health: int = 3
var components: Array = []
var is_dead: bool = false

# Constants
const MIN_DAMAGE_TAKEN: float = 1.0
const OFFSCREEN_POSITION: Vector2 = Vector2(-10000, -10000)

# Signal for object pooling
signal died(mob: CharacterBody2D)

func _ready():
	apply_enemy_data(stats)
	_find_player()

func _find_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	else:
		push_warning("No player found in 'player' group")

func apply_enemy_data(data: EnemyData):
	if not data:
		return
	stats = data
	current_health = stats.max_health
	is_dead = false
	# Apply visual properties if available
	_update_health_display()


func _update_health_display():
	if health_label:
		var display_health = current_health
		health_label.text = str(display_health)

func _physics_process(_delta: float) -> void:
	if not _can_move():
		return
	_move_toward_player()

func _can_move() -> bool:
	return player and not is_dead

func _move_toward_player():
	var direction = global_position.direction_to(player.global_position)
	var move_speed = stats.speed if stats else 100.0
	velocity = direction * move_speed
	move_and_slide()


func take_damage(base_damage: float):
	if is_dead:
		return
	%EnemyHurt.play()
	var defense = stats.defense if stats else 1.0
	var reduced_damage = max(base_damage - defense, MIN_DAMAGE_TAKEN)
	current_health -= reduced_damage
	_update_health_display()
	#$AnimationPlayer.play("hurt")
	flash_hurt()
	if current_health <= 0:
		die()


func flash_hurt():
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 0.3, 0.3), 0.1)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.1)


func die():
	if is_dead:
		return
	is_dead = true
	%EnemyDied.play()
	# Award score
	var score_value = stats.exp_value if stats else 10
	GameStats.add_score(score_value)
	# Drop coins
	coin_drop.drop_coin(global_position)
	# Drop Skill Orb
	skill_orb_drop.drop_skill_orb(global_position)
	# Emit signal for object pooling
	await %EnemyDied.finished
	died.emit(self)

func reset_mob():
	current_health = stats.max_health
	velocity = Vector2.ZERO
	is_dead = false
	position = OFFSCREEN_POSITION
	_update_health_display()

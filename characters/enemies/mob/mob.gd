extends CharacterBody2D

@export var max_health: int = 1
@export var speed: float = 1.0
@export var damage: int = 1

@export var defense: float = 1.0
@export var min_damage_taken: float = 1.0

@onready var player: CharacterBody2D
@onready var coin_drop: CoinDropManager = %CoinDropManager

var current_health: int

func _ready():
	speed = speed * 100.0
	current_health = max_health
	
	# Find player using groups
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta: float) -> void:
	if not player or not is_instance_valid(player):
		return
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage(base_damage: float):
	var reduced_damage = max(base_damage - defense, min_damage_taken) # avoid having 0 damage
	current_health -= reduced_damage
	
	if current_health <= 0:
		Game_Stats.add_score(10)
		coin_drop.drop_coin(global_position)
		queue_free()

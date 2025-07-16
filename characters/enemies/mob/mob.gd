extends CharacterBody2D

@export var max_health: int = 3
@export var speed: float = 1.0
@export var damage: int = 5

@export var defense: float = 1.0
var min_damage_taken: float = 1.0

@onready var player: CharacterBody2D
@onready var coin_drop: CoinDropManager = %CoinDropManager

var current_health: int

# Signal for object pooling
signal died(mob: CharacterBody2D)

func _ready():
	speed = speed * 100.0
	current_health = max_health
	
	# Find player using groups
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	$HealthLabel.text = str(current_health)

func _physics_process(_delta: float) -> void:
	if not player or not is_instance_valid(player):
		return
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage(base_damage: float):
	var reduced_damage = max(base_damage - defense, min_damage_taken) # avoid having 0 damage
	current_health -= reduced_damage
	$HealthLabel.text = str(current_health)
	
	if current_health <= 0:
		die()

func die():
	Game_Stats.add_score(10)
	coin_drop.drop_coin(global_position)
	# Emit signal for object pooling
	died.emit(self)

# Reset function for object pooling
func reset_mob():
	current_health = max_health
	velocity = Vector2.ZERO
	$HealthLabel.text = str(current_health)
	position = Vector2(-10000, -10000)


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_aoe"):
		take_damage(area.damage)

extends Resource
class_name EnemyData

@export var enemy_name: String = "mob"
@export var max_health: int = 3
@export var speed: float = 100.0
@export var damage: int = 5
@export var defense: float = 1.0
@export var score_value: int = 10

# Abilities
#@export var can_shoot: bool = false
#@export var shoot_cooldown: float = 2.0
#@export var projectile_speed: float = 300.0
#@export var projectile_damage: int = 3
#@export var projectile_range: float = 800.0

# Behavior
@export var movement_type: MovementType = MovementType.CHASE

enum MovementType {
	CHASE
}

# Coin drop settings
@export var coin_drop_chance: float = 0.8
@export var coin_drop_min: int = 1
@export var coin_drop_max: int = 10

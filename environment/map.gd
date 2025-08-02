extends Node2D

# Pool references
@onready var regular_pool = $RegularPool
@onready var tank_pool = $TankPool
@onready var vanguard_pool = $VanguardPool
@onready var school_pool = $SchoolPool

# Mob spawn weights (higher = more common)
@export var mob_weights: Dictionary = {
	"regular": 70,    # 70% chance
	"school": 10,       # 20% chance  
	"vanguard": 20    # 10% chance
}

func spawn_mob():
	# Determine mob type based on weights
	var mob_type = _get_weighted_mob_type()
	
	# Get mob from appropriate pool
	var mob = _get_mob_from_pool(mob_type)
	if not mob:
		print("No ", mob_type, " mobs available in pool")
		return
	
	# Set spawn position
	%PathFollow2D.progress_ratio = randf()
	mob.global_position = %PathFollow2D.global_position

func _get_weighted_mob_type() -> String:
	var total_weight = 0
	for weight in mob_weights.values():
		total_weight += weight
	
	var random_value = randi() % total_weight
	var current_weight = 0
	
	for mob_type in mob_weights.keys():
		current_weight += mob_weights[mob_type]
		if random_value < current_weight:
			return mob_type
	
	return "regular"  # fallback

func _get_mob_from_pool(mob_type: String) -> Node2D:
	match mob_type:
		"regular":
			return regular_pool.get_object()
		"tank":
			return tank_pool.get_object()
		"vanguard":
			return vanguard_pool.get_object()
		_:
			return regular_pool.get_object()  # fallback

func _on_spawn_timer_timeout() -> void:
	spawn_mob()

# Debug function to check spawn distribution
func get_spawn_stats() -> Dictionary:
	return {
		"weights": mob_weights,
		"total_weight": mob_weights.values().reduce(func(a, b): return a + b, 0)
	}

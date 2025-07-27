extends Node2D
class_name CoinDropManager

@export var drop_chance: float = 0.3

const COIN_SCENE_PATH := "res://coin_item/coin.tscn"
const MIN_VALUE := 0
const MAX_VALUE := 10

func drop_coin(drop_position: Vector2) -> void:
	# Use call_deferred to avoid physics query conflicts
	call_deferred("_deferred_drop_coin", drop_position)

func _deferred_drop_coin(drop_position: Vector2) -> void:
	var coin_instance = preload(COIN_SCENE_PATH).instantiate()
	var value = randi_range(MIN_VALUE, MAX_VALUE)

	var is_drop = randf() < drop_chance

	if value > 0 and is_drop:
		coin_instance.set_value(value)
		#print_debug("Dropping coin at: ", drop_position)
		
		get_tree().current_scene.add_child(coin_instance)
		coin_instance.global_position = drop_position

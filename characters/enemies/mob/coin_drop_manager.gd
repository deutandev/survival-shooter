extends Node2D
class_name CoinDropManager
 
const MIN_VALUE := 0
const MAX_VALUE := 10

func drop_coin(position: Vector2) -> void:
	var coin_instance = preload("res://drop_item/coin.tscn").instantiate()
	if coin_instance.has_method("set_value"):
		var value = randi_range(MIN_VALUE, MAX_VALUE)
		coin_instance.set_value(value)
	print_debug("Dropping coin at: ", position)
	
	get_tree().current_scene.add_child(coin_instance)
	coin_instance.global_position = position

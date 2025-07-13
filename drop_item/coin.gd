extends Area2D
class_name Coin

var value := 1

func set_value(v: int):
	value = v


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print_debug("Collected coin worth: ", value)
		Game_Stats.add_coin(value)
		queue_free()

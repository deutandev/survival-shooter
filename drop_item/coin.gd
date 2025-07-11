extends Area2D
class_name Coin

var value := 0

func set_value(v: int):
	value = v

func collect():
	print_debug("Collected coin worth: ", value)
	queue_free()

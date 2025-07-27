extends Area2D
class_name Coin

signal coin_collected

var value := 1
@onready var audio := $AudioStreamPlayer2D

func set_value(v: int):
	value = v

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#print_debug("Collected coin worth: ", value)
		GameStats.add_coin(value)
		audio.play()
		visible = false
		await audio.finished
		queue_free()

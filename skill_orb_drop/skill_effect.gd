extends Node2D
class_name SkillEffect

var duration: float = 5.0

func apply(_player):
	pass  # to override

func _on_timer_timeout():
	queue_free()

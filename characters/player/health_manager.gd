extends Node2D
class_name HealthManager

signal health_changed(current, max)
signal dead

var max_health:int = 100
var current_health:int = max_health

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health = max(current_health - amount, 0)
	print("current h", amount)
	emit_signal("health_changed", current_health, max_health)
	if current_health == 0:
		emit_signal("dead")

func heal(amount: int):
	current_health = min(current_health + amount, max_health)
	emit_signal("health_changed", current_health, max_health)

func is_dead() -> bool:
	return current_health <= 0

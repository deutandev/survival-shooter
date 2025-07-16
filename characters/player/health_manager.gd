extends Node
class_name HealthManager

signal health_changed()
signal dead

@export var max_health := 100
var current_health := max_health

func _ready():
	reset()

func take_damage(damage_amount: int):
	#print_debug("Take Damage")
	current_health -= damage_amount
	health_changed.emit(current_health)
	if current_health <= 0:
		dead.emit()

func reset():
	current_health = max_health
	health_changed.emit(current_health)

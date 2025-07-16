extends "res://characters/enemies/mob/mob.gd"


func _ready() -> void:
	speed = randf_range(0.1, 0.8)

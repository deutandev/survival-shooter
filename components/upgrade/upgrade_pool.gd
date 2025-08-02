extends Node


@export var upgrades = [
	preload("res://components/upgrade/data/upgrade_health.tres"),
	preload("res://components/upgrade/data/upgrade_speed.tres"),
	preload("res://components/upgrade/data/upgrade_defense.tres")
]


func get_random_upgrades(count: int = 3) -> Array:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var pool = upgrades.duplicate()
	var selected: Array = []

	while selected.size() < count and pool.size() > 0:
		var i = rng.randi_range(0, pool.size() - 1)
		selected.append(pool[i])
		pool.remove_at(i)

	return selected

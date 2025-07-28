## characters/enemies/school_mob/school_mob.gd
#extends Node2D
#class_name SchoolMob
#
#signal died
#
#@export var stats: EnemyData
#var current_health: int
#var gears: Array[Node] = []
#var is_dead := false
#
#func _ready():
	## Find all gear instances
	#for child in get_children():
		#if child.has_method("take_damage"):  # If it's a gear mob
			#gears.append(child)
			#child.died.connect(_on_gear_died)
	#
	#_initialize_stats()
#
#func _initialize_stats():
	#if stats:
		#current_health = stats.max_health
		#
		## Apply stats to all gears
		#for gear in gears:
			#if gear.has_method("apply_enemy_data"):
				#var gear_stats = stats.duplicate()
				#gear_stats.max_health = 1  # Each gear has 1 HP
				#gear.apply_enemy_data(gear_stats)
#
#func apply_enemy_data(data: EnemyData):
	#stats = data
	#_initialize_stats()
#
#func take_damage(amount: int):
	#if is_dead:
		#return
	#
	#current_health -= amount
	#
	## Damage a random living gear
	#var living_gears = gears.filter(func(gear): return not gear.is_dead)
	#if living_gears.size() > 0:
		#var random_gear = living_gears[randi() % living_gears.size()]
		#random_gear.take_damage(amount)
#
#func _on_gear_died():
	## Check if all gears are dead
	#var living_gears = gears.filter(func(gear): return not gear.is_dead)
	#if living_gears.size() == 0:
		#die()
#
#func die():
	#if is_dead:
		#return
	#
	#is_dead = true
	#died.emit()
#
#func reset_mob():
	#is_dead = false
	#current_health = stats.max_health if stats else 3
	#
	## Reset all gears
	#for gear in gears:
		#if gear.has_method("reset_mob"):
			#gear.reset_mob()
	#
	## Reset position
	#global_position = Vector2.ZERO

extends Node2D

@onready var mob_pool = $MobPool

func spawn_mob():
	var mob = mob_pool.get_object()
	if not mob:
		print("No mobs available in pool")
		return
	
	# Set spawn position
	%PathFollow2D.progress_ratio = randf()
	mob.global_position = %PathFollow2D.global_position

func _on_spawn_timer_timeout() -> void:
	spawn_mob()

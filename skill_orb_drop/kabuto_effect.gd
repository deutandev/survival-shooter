extends SkillEffect

func apply(player):
	duration = 10.0
	player.speed *= 3
	await get_tree().create_timer(duration).timeout
	player.speed /= 3
	queue_free()

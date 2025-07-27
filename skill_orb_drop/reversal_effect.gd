extends SkillEffect

func apply(player):
	duration = 5.0
	player.reverse_controls = true
	await get_tree().create_timer(duration).timeout
	player.reverse_controls = false
	queue_free()

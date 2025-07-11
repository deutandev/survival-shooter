extends ProgressBar

@export var player: Player

func _ready():
	await get_tree().process_frame
	if !player.health:
		print_debug("No Health")
	if player and player.health:
		max_value = player.health.max_health
		player.health.health_changed.connect(update_bar)
		update_bar(player.health.current_health)
	else:
		print_debug("not exist")

func update_bar(current_health: int) -> void:
	print_debug("Update Bar")
	value = current_health

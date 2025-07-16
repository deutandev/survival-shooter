extends ProgressBar

@export var target_node: Node

func _ready():
	await get_tree().process_frame
	if target_node and target_node.health:
		max_value = target_node.health.max_health
		target_node.health.health_changed.connect(update_bar)
		update_bar(target_node.health.current_health)

func update_bar(current_health: int) -> void:
	#print_debug("Update Bar")
	value = current_health

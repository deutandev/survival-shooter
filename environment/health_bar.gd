extends ProgressBar

@export var target_node: Node

@onready var health_label: Label = $HealthLabel

func _ready():
	await get_tree().process_frame
	if target_node and target_node.health_manager:
		max_value = target_node.health_manager.max_health
		target_node.health_manager.health_changed.connect(update_bar)
		update_bar(target_node.health_manager.current_health)

func update_bar(current_health: int, max_health: int = 100) -> void:
	#print_debug("Update Bar")
	max_value = max_health
	value = current_health

	if health_label:
		health_label.text = str(current_health) + " / " + str(max_health)
	else:
		print("Health label not found in HealthBar")

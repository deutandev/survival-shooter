extends ProgressBar

@export var player: Player

func _ready():
	max_value = player.MAX_HEALTH
	player.health_changed.connect(update)
	update()

func update():
	value = player.current_health

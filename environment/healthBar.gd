extends ProgressBar

@export var player: Player

func _ready():
	player.health_changed.connect(update)
	update()
	

func update():
	value = player.current_health

extends Area2D
class_name Bomb

@export var damage: float = 4.0
@export var aoe_duration: float = 0.5

# hide bomb at start
func _init() -> void:
	visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)

func _do_damage():
	$Timer.wait_time = aoe_duration
	$Timer.start()
	print_debug("start bomb")
	await $Timer.timeout
	disable()

func reset(pos: Vector2):
	global_position = pos
	visible = true
	monitoring = true
	monitorable = true
	call_deferred("_do_damage") # ✅ correct function

func disable():
	visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	
	if $Timer.is_stopped() == false:
		$Timer.stop()

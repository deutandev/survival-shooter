extends Area2D
class_name Bomb

@export var damage: float = 3.0
@export var aoe_duration: float = 0.5

func _ready():
	call_deferred("_do_damage")

func _do_damage():
	$Timer.wait_time = aoe_duration
	$Timer.start()
	print_debug("start bomb")
	var enemies = get_overlapping_areas()
	print_debug("Found %d overlapping areas" % enemies.size())
	
	for enemy in enemies:
		if enemy.is_in_group("enemy"):
			print_debug("Bombed Enemy")
			var enemy_node = enemy.get_parent()
			if enemy_node.has_method("take_damage"):
				enemy_node.take_damage(damage)

	await $Timer.timeout
	disable()

func reset(position: Vector2):
	global_position = position
	visible = true
	monitoring = true
	call_deferred("_do_damage") # ✅ correct function

func disable():
	visible = false
	monitoring = false
	set_deferred("monitoring", false)
	
	if $Timer.is_stopped() == false:
		$Timer.stop()

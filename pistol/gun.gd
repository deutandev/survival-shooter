extends Area2D

var enemies_in_range
var target_enemy

func _physics_process(delta: float) -> void:
	enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	var bullet = preload("res://pistol/bullet.tscn").instantiate()
	bullet.global_position = %ShootingPoint.global_position
	bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(bullet)


func _on_timer_timeout() -> void:
	shoot()

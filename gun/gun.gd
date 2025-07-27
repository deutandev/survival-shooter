extends Area2D

var enemies_in_range
var target_enemy
const BULLET_PATH := "res://gun/bullet.tscn"

signal shoot_direction_changed(is_facing_right: bool)

func _physics_process(delta: float) -> void:
	enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		var is_facing_right = target_enemy.global_position.x > global_position.x
		emit_signal("shoot_direction_changed", is_facing_right)

func shoot():
	var bullet = preload(BULLET_PATH).instantiate()
	bullet.global_position = %ShootingPoint.global_position
	bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(bullet)
	$AudioStreamPlayer.play()


func _on_timer_timeout() -> void:
	shoot()

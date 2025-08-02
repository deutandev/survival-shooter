extends Area2D

const MAX_TARGETS := 15
const BULLET_SCENE := preload("res://gun/bullet.tscn")

var enemies_in_range: Array[Node2D] = []
var target_enemy: Node2D = null

signal shoot_direction_changed(is_facing_right: bool)

func _ready() -> void:
	#connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _physics_process(_delta: float) -> void:
	_clean_invalid_enemies()
	_select_closest_enemy()
	_update_aim_direction()

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("enemy") or enemies_in_range.size() >= MAX_TARGETS:
		return

	enemies_in_range.append(body)
	#body.connect("died", _on_enemy_died.bind(body))

func _on_body_exited(body: Node2D) -> void:
	enemies_in_range.erase(body)

func _on_enemy_died(enemy: Node2D) -> void:
	enemies_in_range.erase(enemy)

func _clean_invalid_enemies() -> void:
	enemies_in_range = enemies_in_range.filter(
		func(e): return e != null and e.is_inside_tree()
	)

func _select_closest_enemy() -> void:
	if enemies_in_range.is_empty():
		target_enemy = null
		return

	var closest_enemy: Node2D = null
	var closest_distance := INF

	for enemy in enemies_in_range:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy

	target_enemy = closest_enemy

func _update_aim_direction() -> void:
	if target_enemy == null:
		return

	look_at(target_enemy.global_position)
	var facing_right := target_enemy.global_position.x > global_position.x
	emit_signal("shoot_direction_changed", facing_right)

func shoot() -> void:
	var bullet = BULLET_SCENE.instantiate()
	bullet.global_position = %ShootingPoint.global_position
	bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(bullet)
	$AudioStreamPlayer.play()

func _on_timer_timeout() -> void:
	shoot()

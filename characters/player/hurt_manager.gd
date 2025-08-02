extends Node
class_name HurtManager

@onready var hurtbox: Area2D = %HurtBox
@onready var hurt_timer: Timer = %HurtTimer
@export var knockback_power := 1000
@export var damage_amount := 5
@export var target: CharacterBody2D
@onready var health: HealthManager = %HealthManager

var is_hurt := false
var is_free := true


func apply_damage(body: Node2D):
	%PlayerHurtSfx.play()
	await %PlayerHurtSfx.finished
	health.take_damage(body.stats.damage)
	apply_knockback(body.velocity)

func apply_knockback(enemy_velocity: Vector2):
	if !target:
		return
	#print_debug("Apply Knockback")
	var knockback_direction = (enemy_velocity - target.velocity).normalized() * knockback_power
	target.velocity = knockback_direction
	
	# knockback if has free space
	if is_free:
		target.move_and_slide()
	else:
		# Defer move_and_slide to avoid physics lock
		call_deferred("_apply_knockback_movement")

# Apply the actual knockback movement (called deferred)
func _apply_knockback_movement():
	if target:
		target.move_and_slide()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		apply_damage(body)
		hurt_timer.start()
		flash_hurt()


func flash_hurt():
	var sprite = get_parent()
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 0.3, 0.3), 0.1)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.1)


func _on_hurt_timer_timeout() -> void:
	is_collide_enemy()

func is_collide_enemy() -> void:
	var bodies = hurtbox.get_overlapping_bodies()
	if bodies.size() > 0:
		is_free = false
		for body in bodies:
			if body.is_in_group("enemy"):
				print(body)
				apply_damage(body)
	else:
		is_hurt = false
		is_free = true

extends Node
class_name HurtManager

@onready var hurtbox: Area2D = %HurtBox
@onready var hurt_timer: Timer = %HurtTimer
@export var knockback_power := 1000
@export var damage_amount := 5
@export var target: CharacterBody2D
@onready var health: HealthManager = %HealthManager

var is_hurt := false

func _physics_process(_delta):
	if is_hurt:
		return
	var overlapping = hurtbox.get_overlapping_areas()
	for area in overlapping:
		if area.is_in_group("enemy"):
			print_debug("HitBox ", area.name)
			apply_damage(area)
			break

func apply_damage(area: Area2D):
	health.take_damage(area.get_parent().damage)
	apply_knockback(area.get_parent().velocity)
	is_hurt = true
	hurt_timer.start()
	await hurt_timer.timeout
	is_hurt = false

func apply_knockback(enemy_velocity: Vector2):
	if !target:
		return
	#print_debug("Apply Knockback")
	var knockback_direction = (enemy_velocity - target.velocity).normalized() * knockback_power
	target.velocity = knockback_direction
	target.move_and_slide()

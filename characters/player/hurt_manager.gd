extends Node
class_name HurtManager

@onready var hurtbox: Area2D = %HurtBox
@onready var hurt_timer: Timer = %HurtTimer
@export var knockback_power := 600
@export var damage_amount := 5
@export var target: CharacterBody2D
@onready var health: HealthManager = %HealthManager

var is_hurt := false

#func _physics_process(_delta):
	#if is_hurt:
		#return
	#var overlapping = hurtbox.get_overlapping_areas()
	#for area in overlapping:
		#if area.is_in_group("enemy"):
			#print_debug("HitBox")
			#apply_damage(area)
			#break

func apply_damage(body: Node2D):
	health.take_damage(damage_amount)
	apply_knockback(body.velocity)
	is_hurt = true
	hurt_timer.start()
	await hurt_timer.timeout
	is_hurt = false

func apply_knockback(enemy_velocity: Vector2):
	if !target:
		return
	print_debug("Apply Knockback")
	var knockback_direction = (enemy_velocity - target.velocity).normalized() * knockback_power
	target.velocity = knockback_direction
	target.move_and_slide()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		apply_damage(body)

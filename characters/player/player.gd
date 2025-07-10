extends CharacterBody2D

class_name Player

signal health_changed
signal player_death

@export var speed := 600
@export var knockback_power := 500
@onready var hurtbox = %HurtBox

@export var MAX_HEALTH := 100
@onready var current_health := MAX_HEALTH
@onready var hurt_timer = %HurtTimer

var isHurt := false

func _ready() -> void:
	current_health = MAX_HEALTH
	%ProgressBar.max_value = MAX_HEALTH
	%ProgressBar.value = current_health

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	if !isHurt:	
		get_input()
	move_and_slide()

func player_hurt(area):
	if isHurt:
		return
		
	current_health -= 5
	print_debug(current_health)
	#current health -= enemy.damage
	%ProgressBar.value = current_health

	if current_health <= 0:
		player_death.emit()
	
	isHurt = true
	health_changed.emit()
	knockback(area.get_parent().velocity)
	hurt_timer.start()
	await hurt_timer.timeout
	isHurt = false
	
func knockback(enemy_velocity: Vector2):
	var knockbackDirection = (enemy_velocity - velocity).normalized() * knockback_power
	velocity = knockbackDirection
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "hitBox":
		print_debug("Hurt")
		player_hurt(area)

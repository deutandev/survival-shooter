extends CharacterBody2D

class_name Player

signal health_changed
signal player_death

@export var speed := 600
@export var knockback_power := 250
@onready var hurtbox = %HurtBox

@export var MAX_HEALTH := 100
@onready var current_health := MAX_HEALTH
@onready var hurt_timer = %HurtTimer

var isHurt := false

func _ready() -> void:
	current_health = MAX_HEALTH
	%ProgressBar.max_value = MAX_HEALTH
	%ProgressBar.value = current_health
	health_changed.emit()

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	if !isHurt:	
		get_input()
	move_and_slide()
	check_hurtbox_for_enemies()

func player_hurt(area):
	current_health -= 5
	print_debug(current_health)
	#current health -= enemy.damage
	%ProgressBar.value = current_health
	if current_health <= 0:
		player_death.emit()
		change_to_main_menu()
		return
	isHurt = true
	health_changed.emit(current_health)
	knockback(area.get_parent().velocity)
	hurt_timer.start()
	await hurt_timer.timeout
	isHurt = false

func knockback(enemy_velocity: Vector2):
	var knockbackDirection = (enemy_velocity - velocity).normalized() * knockback_power
	velocity = knockbackDirection
	move_and_slide()

func check_hurtbox_for_enemies():
	if isHurt:
		return
	var overlapping_areas = hurtbox.get_overlapping_areas()
	for area in overlapping_areas:
		if area.is_in_group("enemy"):
			player_hurt(area)
			break

func change_to_main_menu():
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://environment/mainMenu.tscn")

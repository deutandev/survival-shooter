extends Node2D
class_name UltButton

@export var player: CharacterBody2D
@onready var cooldown_label = %CooldownLabel
@onready var ult_button = $UltButton
var time_left := 0.0
var active := false

func _ready():
	_end_cooldown()
	player.skill_cooldown_started.connect(_start_cooldown)
	player.skill_cooldown_ended.connect(_end_cooldown)

func _process(delta):
	if active:
		time_left -= delta
		if time_left > 0:
			cooldown_label.text = str(ceil(time_left))
		else:
			_end_cooldown()

func _start_cooldown(duration: float):
	ult_button.disabled = true
	time_left = duration
	active = true
	cooldown_label.visible = true
	cooldown_label.text = str(ceil(duration))

func _end_cooldown():
	active = false
	cooldown_label.text = ""
	cooldown_label.visible = false
	ult_button.disabled = false

func _on_ult_button_pressed() -> void:
	player.use_skill()

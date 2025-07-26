extends Node2D

@onready var gameover_panel = %gameover_panel
@export var player : CharacterBody2D

@onready var upgrade_mgr = player.get_node("UpgradeManager")

func _ready():
	gameover_panel.visible = false
	player.player_died.connect(_on_player_died)

func _on_player_died():
	get_tree().paused = true
	gameover_panel.visible = true

	call_deferred("_return_to_main_menu")
	
func _return_to_main_menu():
	await get_tree().create_timer(3.0, true).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://environment/main_menu/mainMenu.tscn")
